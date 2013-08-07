require 'rails_monitor/version'
require 'active_support/concern'

module RailsMonitor
  module Monitoring
    extend ActiveSupport::Concern

    included do
      prepend_view_path(File.join(File.dirname(__FILE__), '..', 'app', 'views'))
      @@statuses ||= {}
      cattr_reader :statuses
    end

    def index
      @statuses = self.statuses

      respond_to do |format|
        format.html do
          render 'rails_monitor/status'
        end
      end
    end

    def render_text_plain(text)
      headers['Content-type'] = 'text/plain'
      render :text => text
    end

    module ClassMethods
      def status_tab(anchor, statuses_to_show = [])
        self.statuses[anchor] = statuses_to_show
      end

      def boolean_status(name)
        raise ArgumentError('No block given') unless block_given?

        define_method(name) do
          result = yield

          if result
            render_text_plain "OK: #{result}"
          else
            render_text_plain "ERROR: #{result}"
          end
        end
      end
    
      def numeric_status(name, default_warn_threshold = nil, default_error_threshold = nil)
        raise ArgumentError('No block given') unless block_given?
    
        define_method(name) do
          result = yield.to_i

          warn_threshold = default_warn_threshold || params[:warn_threshold]
          error_threshold = default_error_threshold || params[:error_threshold]

          if error_threshold && result >= error_threshold.to_i
            render_text_plain "ERROR: #{result}"
          elsif warn_threshold && result >= warn_threshold.to_i
            render_text_plain "WARN: #{result}"
          else
            render_text_plain "OK: #{result}"
          end
        end
      end
    end
  end
end
