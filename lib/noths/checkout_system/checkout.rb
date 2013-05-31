require "bigdecimal"

module Noths
  module CheckoutSystem
    class Checkout

      include Noths::Utils::NumericalOperations

      attr_reader :items
      attr_reader :checkout_rules

      attr_reader :total_price
      attr_accessor :total_checkout_price

      def initialize(checkout_rules)
        @checkout_rules = checkout_rules
        @items = []
      end

      def scan(item)
        @items << item
        recalculate_totals
        apply_checkout_rules
      end

      private

      def recalculate_totals
        recalculate_total_price
        recalculate_total_checkout_price
      end

      def recalculate_total_price
        sum = @items.map(&:price).inject(&:+)
        @total_price = create_big_decimal(sum)
      end

      def recalculate_total_checkout_price
        sum = @items.map(&:checkout_price).inject(&:+)
        @total_checkout_price = create_big_decimal(sum)
      end

      def apply_checkout_rules
        current_context = self
        @checkout_rules.each do |rule|
          rule.apply current_context
        end
      end

    end
  end
end
