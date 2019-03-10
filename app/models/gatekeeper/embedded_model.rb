##
# This is an example embedded model used for testing purposes.
# It represents a real world model with various fields and methods.

module Gatekeeper
  class EmbeddedModel

    include Mongoid::Document

    field         :string_field,          type: String

    embedded_in   :model,           class_name: 'Gatekeeper::Model'

  end
end
