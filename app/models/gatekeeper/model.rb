##
# This is an example model used for testing purposes.
# It represents a real world model with various fields and methods.

module Gatekeeper
  class Model

    include Mongoid::Document

    field         :string_field,            type: String
    field         :number_field,            type: Float
    field         :date_field,              type: Date

    embeds_many   :embedded_models,   class_name: 'Gatekeeper::EmbeddedModel'

    has_many      :related_models,    class_name: 'Gatekeeper::RelatedModel'

    ##
    # Allowed info.
    allowed_info do |user|
      case user.role
      when :editor
        document_fields
      end
    end

  end
end
