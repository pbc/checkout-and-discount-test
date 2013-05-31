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
        @basket.add_item(item)
      end

      def total
        basket.total_checkout_price
      end

      private

      def apply_checkout_rules
        @checkout_rules.each do |rule|
          rule.apply @basket
        end
      end

    end
  end
end
