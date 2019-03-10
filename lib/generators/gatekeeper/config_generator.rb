require 'rails/generators'

module Gatekeeper
  module Generators
    
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a gatekeeper configuration file."

      def copy_config
        template "gatekeeper.rb", "config/initializers/gatekeeper.rb"
      end

    end

  end
end