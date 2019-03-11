module Gatekeeper
  class Configuration

    # @return [Proc] a block to return bypess all info allowances (ex. for an admin user).
    attr_accessor :bypass_allowed_info
    # @return [Array<Symbol>] a list of ignored variables in controller response.
    attr_accessor :response_ignored_variables

    def initialize
      @bypass_allowed_info = nil
      @response_ignored_variables = []
    end

  end
end
