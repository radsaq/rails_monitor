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

    module ClassMethods
      def status_tab(anchor, statuses_to_show = [])
        self.statuses[anchor] = statuses_to_show
      end

      def boolean_status(name)
        raise ArgumentError('No block given') unless block_given?

        define_method(name) do
          result = yield

          if result
            render :text => "OK: #{result}"
          else
            render :text => "ERROR: #{result}"
          end
        end
      end
    
      def numeric_status(name, warn_threshold = nil, error_threshold = nil)
        raise ArgumentError('No block given') unless block_given?
    
        define_method(name) do
          result = yield.to_i

          if error_threshold && result >= error_threshold
            render :text => "ERROR: #{result}"
          elsif warn_threshold && result >= warn_threshold
            render :text => "WARN: #{result}"
          else
            render :text => "OK: #{result}"
          end
        end
      end
    end
  end
end
