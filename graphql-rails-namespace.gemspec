Gem::Specification.new do |s|
  s.name     = "graphql-rails-namespace"
  s.version  = "0.1.0"
  s.authors  = "George Claghorn"
  s.email    = "georgeclaghorn@gmail.com"
  s.summary  = "Namespace GraphQL-related constants in Rails apps"
  s.homepage = "https://github.com/georgeclaghorn/graphql-rails-namespace"
  s.license  = "MIT"

  s.required_ruby_version = ">= 3.0.0"

  s.add_dependency "railties", ">= 6.1.0"

  s.files      = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
end
