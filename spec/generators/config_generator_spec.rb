require 'generators/gatekeeper/config_generator'

# Includes Thor actions to handle files
require 'thor'
include Thor::Base
include Thor::Actions

RSpec.describe Gatekeeper::Generators::ConfigGenerator do

  it "generates a configuration file for the gatekeeper" do

    remove_file 'test/dummy/config/initializers/gatekeeper.rb'
    Gatekeeper::Generators::ConfigGenerator.start([], destination_root: 'test/dummy')
    expect(File).to exist('test/dummy/config/initializers/gatekeeper.rb')
    
  end

end
