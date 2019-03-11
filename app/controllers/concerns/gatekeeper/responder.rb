module Gatekeeper
  module Responder

    extend ActiveSupport::Concern

      included do

        respond_to    :html, :js, :json

        before_action :set_current_user
        after_action  :handle_response

        ##
        # Handles response based on request format.
        def handle_response
          unless performed?
            if @error.present?
              handle_error(@error)
            else
              respond_with do |format|
                # Browser scope.
                format.html do
                  handle_response_html
                end
                # Rails remote form.
                format.js do
                  handle_response_js
                end
                # API / xhr scope.
                format.json do
                  handle_response_json
                end
              end
            end
          end
        end

        ##
        # Handles any error case.
        def handle_error(error)
          # Can be overridden
          render plain: error.inspect, status: 500
        end

        ##
        # Sets current user.
        def set_current_user
          # Can be overridden
          @current_user = Gatekeeper::User.new
        end

        protected

          ##
          # Handles HTML response.
          def handle_response_html
            if @errors.present? and action_name.in? [ 'create', 'update' ]
              case action_name
              when 'create' then render 'new.html'
              when 'update' then render 'edit.html'
              end
            else
              if @redirect_to.present?
                redirect_to @redirect_to
              else
                case action_name
                when 'create', 'update' then redirect_to(action: 'index')
                when 'destroy' then redirect_to(action: 'index')
                else render "#{action_name}.html" end
              end
            end
          end

          ##
          # Handles JS response.
          def handle_response_js
            render "#{action_name}.js"
          end

          ##
          # Gestisce il tipo di risposta JSON.
          def handle_response_json
            assigns = {}
            if instance_variables.include? :@errors
              assigned_variables = [ :@errors ]
            else
              assigned_variables = instance_variables.reject do |variable|
                variable.to_s.starts_with?('@_') or variable.in? Gatekeeper.response_ignored_variables
              end
            end
            assigned_variables.each do |variable|
              variable_value = instance_variable_get(variable)
              assigns[variable.to_s.gsub('@', '').camelize(:lower)] =
                if variable_value.respond_to? :info
                  variable_value.info(@current_user, keys: :camelized)
                else
                  variable_value.as_json
                end
            end
            render json: assigns
          end

      end

  end
end
