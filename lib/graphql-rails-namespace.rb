require "rails/railtie"

class GraphQLRailsNamespace < Rails::Railtie
  config.graphql = ActiveSupport::OrderedOptions.new unless config.respond_to?(:graphql)
  config.graphql.path = "app/graphql"
  config.graphql.namespace = ::ApplicationGraph ||= Module.new

  initializer :remove_graphql_path_from_default_eager_load_paths, before: :set_eager_load_paths do |app|
    app.config.eager_load_paths -= [ full_graphql_path ]
  end

  initializer :watch_graphql_path do
    config.watchable_dirs[full_graphql_path] = %w[ .rb ]
  end

  initializer :autoload_from_graphql_path do
    Rails.autoloaders.main.push_dir full_graphql_path, namespace: config.graphql.namespace
  end

  private
    def full_graphql_path
      "#{Rails.root}/#{config.graphql.path}"
    end
end
