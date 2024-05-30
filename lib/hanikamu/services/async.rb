# frozen_string_literal: true

require 'active_support/concern'
require 'active_job'
require 'active_support/core_ext/module/introspection'

module Hanikamu
  module Services
    # You can call from the operation the method
    # to define the queue in which will run using the same syntax
    # like in active_job
    module Async
      extend ActiveSupport::Concern

      class_methods do
        def queue_as(priority)
          self::Async.queue_as(priority)
        end

        # Use in your operation as in an active_job
        def rescue_from(error, &blk)
          self::Async(error, &blk)
        end

        def retry_on(error, wait: 5, attempts: 5)
          self::Async.retry_on error, wait: wait.seconds, attempts: attempts
        end
      end

      # call operation using SomeOperation::Async
      # in order to make it Async with retry queue
      # rubocop:disable Metrics/MethodLength
      def self.included(base)
        base.class_eval do
          const_set(
            :Async,
            Class.new(ActiveJob::Base) do
              class << self
                def call!(args = {})
                  perform_later(args: args, bang: true)
                end

                def call(args = {})
                  perform_later(args: args, bang: false)
                end
              end

              def perform(args:, bang:)
                parent_name_space.public_send(bang ? :call! : :call, args)
              end

              private

              def parent_name_space
                self.class.name.deconstantize.constantize
              end
            end
          )
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
