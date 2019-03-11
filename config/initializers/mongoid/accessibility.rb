module Mongoid
  module Document

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      ##
      # Defines a user's accessible info.
      def allowed_info(&block)
        define_singleton_method :allowed_info_names do |user|
          Gatekeeper.default_allowed_info_names(user, self, &block)
        end
      end

    end

    ##
    # Returns fields, embeds and relations based on current user's allowed info.
    def info(current_user = nil, options = {})
      if current_user.present?
        if self.class.respond_to? :allowed_info_names
          exposed_info = self.class.allowed_info_names(current_user)
        else
          exposed_info = Gatekeeper.default_allowed_info_names(current_user, self.class)
        end
      else
        exposed_info = document_fields | document_embeds
      end

      output = {}
      # Maps id
      output.store :id, self.id.to_s
      # Maps all fields
      (self.class.document_fields & exposed_info).each do |field_name|
        output.store field_name, self.send(field_name)
      end
      # Maps embedded relations
      (self.class.document_embeds & exposed_info).each do |embed_name|
        embed = self.send(embed_name)
        if embed.is_a? Array
          output[embed_name] = embed.map do |embedded_document|
            embedded_document.info(current_user)
          end
        else
          output[embed_name] = embed.info(current_user)
        end
      end
      # Maps standard relations (only if included in the options)
      self.class.document_relations & ([ options[:include] ].compact.flatten).each do |relation_name|
        relation = self.send(relation_name)
        if relation.is_a? Mongoid::Association::Referenced::HasMany::Targets::Enumerable
          output[relation_name] = relation.map do |related_document|
            related_document.info(current_user)
          end
        else
          output[relation_name] = relation.info(current_user)
        end
      end

      # Transforms output keys
      if options[:keys].present?
        case options[:keys]
        when :camelized
          output.transform_keys! do |key|
            key.to_s.camelize(:lower).to_sym
          end
        end
      end

      output
    end

  end

  class Criteria

    ##
    # Returns allowed info for current user.
    def info(current_user, options = {})
      if @included_relations.present? and @included_relations.any?
        self.map do |document|
          document.info(current_user, options.merge(include: @included_relations))
        end
      else
        self.map do |document|
          document.info(current_user, options)
        end
      end
    end

  end
end
