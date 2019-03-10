module Gatekeeper
  class Configuration

    # @return [Proc] a block to return bypess all info allowances (ex. for an admin user).
    attr_accessor :bypass_allowed_info

    def initialize
      @bypass_allowed_info = nil
    end

  end
end
