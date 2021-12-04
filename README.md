# GraphQL namespace for Rails

Tuck GraphQL-related modules and classes into an appropriate top-level namespace.

The [GraphQL Ruby] library encourages placing GraphQL modules and classes such as type definitions under the `app/graphql/` directory in Rails applications. Here’s an example from the GraphQL Ruby homepage:

```ruby
# app/graphql/types/profile_type.rb
class Types::ProfileType < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :avatar, Types::PhotoType
end
```

Because Rails treats all subdirectories of `app/` as root directories for the purpose of autoloading, classes in `app/graphql/types/` are nested in a top-level `Types` module. In the above example, `app/graphql/types/profile_type.rb` defines `Types::ProfileType`. But `Types` is too general a top-level namespace for GraphQL type definitions. The GraphQL schema class defined in `app/graphql/schema.rb` is named `Schema`, but it’s specifically a GraphQL schema, not a generic schema. It would be nice to nest GraphQL-specific modules and classes in a GraphQL-specific namespace.

[GraphQL Ruby]: https://graphql-ruby.org

## Usage

Add `gem "graphql-rails-namespace"` to your Gemfile and run `bundle install`.

Modify existing files in `app/graphql/` to define modules and classes under the top-level `ApplicationGraph` namespace.

```ruby
# app/graphql/types/profile_type.rb
class ApplicationGraph::Types::ProfileType < ApplicationGraph::Types::BaseObject
  # ...
end

# ...or...

module ApplicationGraph::Types
  class ProfileType < BaseObject
  end
end
```

Use the `ApplicationGraph` namespace for new modules and classes you add to `app/graphql`.

## Configuration

Custom configuration must be placed in `config/application.rb`. Initializers run too late.

### `config.graphql.path`

**`config.graphql.path`** contains the path to the GraphQL code directory, relative to `Rails.root`. It’s `app/graphql` by default.

To use a different directory:

```ruby
# config/application.rb
module Foo
  class Application < Rails::Application
    # ...

    config.graphql.path = "app/path/to/graph"
  end
end
```

### `config.graphql.namespace`

**`config.graphql.namespace`** contains the top-level module for `config.graphql.path`. It’s `::ApplicationGraph` by default.

To use a different namespace:

```ruby
# config/application.rb
module Foo
  class Application < Rails::Application
    # ...

    config.graphql.namespace = ::MyGraph = Module.new
  end
end
```

## License

This plugin is distributed under the terms of the [MIT License](https://opensource.org/licenses/MIT). See LICENSE.md for details.
