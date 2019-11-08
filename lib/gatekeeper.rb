require "gatekeeper/engine"
require "gatekeeper/configuration"

module Gatekeeper
  
  class << self

    # @return [Gatekeeper::Configuration] the configuration class for Gatekeeper.
    attr_accessor :configuration

    ##
    # Initializes configuration.
    #
    # @return [Gatekeeper::Configuration] the configuration class for Gatekeeper.
    def configuration
      @configuration || Gatekeeper::Configuration.new
    end

    ##
    # Method to configure various Gatekeeper options.
    #
    # @return [nil]
    def configure
      @configuration ||= Gatekeeper::Configuration.new
      yield @configuration
    end

    ##
    # Returns default allowed info names for a user.
    #
    # @param [Object] the user.
    # @param [Class] the model class.
    #
    # @return [Array<Symbol>] default allowed info names.
    def default_allowed_info_names(user, model_class, &block)
      if configuration.bypass_allowed_info.respond_to? :call
        bypassable = configuration.bypass_allowed_info.call(user)
      else
        bypassable = false
      end

      if bypassable
        # Sees everything!
        model_class.document_all_info
      else
        if block_given?
          block.call(user) || []
        else
          []
        end
      end
    end

    ##
    # Variables to not include in controller response.
    #
    # @return [Array<Symbol>] ignored variables.
    def response_ignored_variables
      Gatekeeper.configuration.response_ignored_variables | [
        :@marked_for_same_origin_verification, :@browser,
        :@behavior, :@options, :@args, :@shell, :@destination_stack ]
    end

  end

end
