require "bigdecimal"

module Noths
  module CheckoutSystem
    class Checkout

      include Noths::Utils::NumericalOperations

      attr_reader :checkout_rules
      attr_reader :basket

      def initialize(checkout_rules)
        @checkout_rules = checkout_rules
        @items = []
        @basket = Noths::Providers::Basket.instantiate
      end

      def scan(item)
        basket.reset_item_checkout_prices
        basket.add_item(item)
        basket.recalculate_totals
        apply_per_item_rules
        basket.recalculate_totals
        apply_per_total_rules
      end

      def total
        basket.total_checkout_price
      end

      private

      def apply_per_item_rules
        apply_rules(per_item_rules)
      end

      def apply_per_total_rules
        apply_rules(per_total_rules)
      end

      def apply_rules(rules)
        rules.each do |rule|
          rule.apply @basket
        end
      end

      def per_item_rules
        @checkout_rules.select(&:is_per_item_rule?)
      end

      def per_total_rules
        @checkout_rules.select(&:is_per_total_rule?)
      end

    end
  end
end
