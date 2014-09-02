require 'lotus/view/rendering/layout_scope'
require 'lotus/view/rendering/template'
require 'lotus/view/rendering/partial'

module Lotus
  module View
    module Rendering
      # Rendering scope
      #
      # @since 0.1.0
      #
      # @see Lotus::View::Rendering::LayoutScope
      class Scope < LayoutScope
        # Initialize the scope
        #
        # @param view [Class] the view
        # @param locals [Hash] a set of objects available during the rendering
        # @option locals [Symbol] :format the requested format
        #
        # @api private
        # @since 0.1.0
        def initialize(view, locals = {})
          @view, @locals = view, locals
        end

        # Returns the requested format.
        #
        # @return [Symbol] the requested format (eg. :html, :json, :xml, etc..)
        #
        # @since 0.1.0
        def format
          locals[:format]
        end

        # Implements "respond to" logic
        #
        # @return [TrueClass,FalseClass]
        #
        # @since x.x.x
        # @api private
        #
        # @see http://ruby-doc.org/core/Object.html#method-i-respond_to_missing-3F
        def respond_to_missing?(m, include_all)
          @view.respond_to?(m) ||
            @locals.key?(m)
        end

        protected
        def method_missing(m, *args, &block)
          if @view.respond_to?(m)
            @view.__send__ m, *args, &block
          elsif @locals.key?(m)
            @locals[m]
          else
            super
          end
        end
      end
    end
  end
end
