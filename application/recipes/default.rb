data_bag("apps").each do |a|

  app = data_bag_item("apps", a)

  # Install any application-specific packages
  if app['packages']
    app['packages'].each do |pkg, ver|
      package pkg do
        action :install
        version ver if ver && ver.length > 0
      end
    end
  end

  # Create the deploy directory (owned by the deploy user)
  directory app['deploy_to'] do
    owner app['owner']
    group app['group']
    mode '0755'
    recursive true
  end

  # Create shared directories (owned by the deploy user)
  %w{ log pids system vendor_bundle }.each do |dir|
    directory "#{app['deploy_to']}/shared/#{dir}" do
      owner app['owner']
      group app['group']
      mode '0755'
      recursive true
    end
  end

  # Add the SSH deploy key
  if app.has_key?("deploy_key")
    ruby_block "write_key" do
      block do
        f = ::File.open("#{app['deploy_to']}/id_deploy", "w")
        f.print(app["deploy_key"])
        f.close
      end
      not_if do ::File.exists?("#{app['deploy_to']}/id_deploy"); end
    end

    file "#{app['deploy_to']}/id_deploy" do
      owner app['owner']
      group app['group']
      mode '0600'
    end

    template "#{app['deploy_to']}/deploy-ssh-wrapper" do
      source "deploy-ssh-wrapper.erb"
      owner app['owner']
      group app['group']
      mode "0755"
      variables app.to_hash
    end
  end

  template "#{app['deploy_to']}/shared/database.yml" do
    source "database.yml.erb"
    owner app["owner"]
    group app["group"]
    mode "644"
    variables(
      :databases   => app['databases'],
      :environment => app['environment']
    )
  end

  # template "/etc/nginx/sites-enabled/#{app['domain']}.conf" do
  #   source "rails_nginx_passenger.conf.erb"
  #   owner "root"
  #   group "root"
  #   mode "0644"
  #   variables(
  #     :environment => app['environment'],
  #     :domain      => app['domain'],
  #     :docroot     => app['deploy_to'] + "/current/public"
  #   )
  #   notifies :restart, resources(:service => "nginx"), :delayed
  # end

  # Deploy the application
  deploy_revision app['id'] do
    revision app['revision'][app['environment']]
    repository app['repository']
    user app['owner']
    group app['group']
    deploy_to app['deploy_to']
    environment 'RAILS_ENV' => app['environment']
    ssh_wrapper "#{app['deploy_to']}/deploy-ssh-wrapper" if app['deploy_key']
    # action app['force'][app['environment']] ? :force_deploy : :deploy
    # restart_command "touch tmp/restart.txt"

    before_migrate do

      template "#{release_path}/.rbenv-version" do
        source "rbenv-version.erb"
        owner app["owner"]
        group app["group"]
        mode "644"
        variables(
          :ruby_version => app['ruby_version']
        )
      end

      link "#{release_path}/vendor/bundle" do
        to "#{app['deploy_to']}/shared/vendor_bundle"
      end
      common_groups = %w{development test staging production}
      execute "bundle install --deployment --without #{(common_groups -([app['environment']])).join(' ')} --binstubs --shebang ruby-local-exec" do
        ignore_failure true
        cwd release_path
      end
    end

    symlink_before_migrate({
      "database.yml"   => "config/database.yml"
      # "sunspot.yml"    => "config/sunspot.yml",
      # "app_config.yml" => "config/app_config.yml"
    })

    # if app['migrate'][app['environment']] && node[:apps][app['id']][app['environment']][:run_migrations]
    #   migrate true
    #   migration_command app['migration_command'] || "rake db:migrate"
    # else
    #   migrate false
    # end
    # before_symlink do
    #   ruby_block "remove_run_migrations" do
    #     block do
    #       if node.role?("#{app['id']}_run_migrations")
    #         Chef::Log.info("Migrations were run, removing role[#{app['id']}_run_migrations]")
    #         node.run_list.remove("role[#{app['id']}_run_migrations]")
    #       end
    #     end
    #   end
    # end
  end

end