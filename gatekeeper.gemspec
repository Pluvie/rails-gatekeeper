$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "gatekeeper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "rails-mongoid-gatekeeper"
  spec.version     = Gatekeeper::VERSION
  spec.authors     = ["Francesco Ballardin"]
  spec.email       = ["francesco.ballardin@develonproject.com"]
  spec.homepage    = "https://github.com/Pluvie/rails-gatekeeper"
  spec.summary     = "Provides various access control methods to models and controllers. To use with MongoDB."
  spec.description = "Provides various access control methods to models and controllers. To use with MongoDB."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"
  spec.add_dependency "mongoid", ">= 7.0.0"
  spec.add_dependency "bson_ext"
  spec.add_dependency "responders"
end
