##
# This is an example related model used for testing purposes.
# It represents a real world model with various fields and methods.

module Gatekeeper
  class RelatedModel

    include Mongoid::Document

    field         :string_field,          type: String

    belongs_to    :model,           class_name: 'Gatekeeper::Model'

  end
end
