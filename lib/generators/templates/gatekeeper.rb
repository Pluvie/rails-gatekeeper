##
# Example configuration file for rails-gatekeeper gem.
Gatekeeper.configure do |config|

  ##
  # Determines which user can bypass all allowed info, and
  # see everything of a specified model. Usually this applies
  # to admin users.
  #
  # Example:
  #   config.bypass_allowed_info = proc do |user|
  #     user.is_admin?
  #   end
  #
  # Defaults to nil, which is equal to no bypassable users.
  #
  # config.bypass_allowed_info = nil

  ##
  # Sets which controller instance variables to not include in the response.
  #
  # Defaults to empty array.
  #
  # config.response_ignored_variables = []

end
