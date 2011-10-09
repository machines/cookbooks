recipe_keys = []
app_keys = []

# Search the apps and determine what recipes
# need to be run based on app data bags
data_bag("apps").each do |a|

  app = data_bag_item("apps", a)
  recipe = app["type"]

  unless node.run_state[:"#{recipe}_apps"]
    node.run_state[:"#{recipe}_apps"] = []
    app_keys << :"#{recipe}_apps"
  end

  node.run_state[:"#{recipe}_apps"] << app
  recipe_keys << recipe

end

# Include all the recipies we need
recipe_keys.each do |recipe|
  include_recipe "application::#{recipe}"
end

# Clean up
app_keys.each { |k| node.run_state.delete(k) }
