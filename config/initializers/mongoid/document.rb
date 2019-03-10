module Mongoid
  module Document

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      ##
      # Returns all 'fields' of a document.
      def document_fields
        self.fields.keys
          .reject { |field| field.ends_with?('_id') or field.ends_with?('_ids') }
          .map(&:to_sym)
      end

      ##
      # Returns all 'embedded' relation names of a document.
      def document_embeds
        self.relations.keys
          .select { |relation_name| self.relations[relation_name].embedded? }
          .reject { |relation_name| self.relations[relation_name].is_a? Mongoid::Association::Embedded::EmbeddedIn }
          .map(&:to_sym)
      end

      ##
      # Returns all 'standard' relation names of a document.
      def document_relations
        self.relations.keys
          .reject { |relation_name| self.relations[relation_name].embedded? }
          .map(&:to_sym)
      end

      ##
      # Returns all document info.
      def document_all_info
        document_fields | document_embeds | document_relations
      end

    end

  end

  class Criteria

    attr_accessor :included_relations

    ##
    # Stores included relations.
    def includes(*relations)
      @included_relations = relations
      super
    end

  end
end
