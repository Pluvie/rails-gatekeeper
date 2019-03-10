##
# Example a of a user.
module Gatekeeper
  class User

    include Mongoid::Document

    field   :name,        type: String
    field   :role,        type: Symbol

  end
end
