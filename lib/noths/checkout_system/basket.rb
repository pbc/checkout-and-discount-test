
module Noths
  module CheckoutSystem
    class Basket
      include Noths::Utils::NumericalOperations

      attr_reader :items

      def initialize
        @items = []
      end

      def add_item(item)
        @items << item
      end

      def total_price
        @total_price ||= create_big_decimal(0.0)
      end

      def total_checkout_price
        @total_checkout_price ||= create_big_decimal(0.0)
      end

      def total_checkout_price=(value)
        @total_checkout_price = create_big_decimal(value)
      end

      def reset_item_checkout_prices
        @items.each do |item|
          item.reset_checkout_price
        end
      end

      def recalculate_totals
        recalculate_total_price
        recalculate_total_checkout_price
      end

      def recalculate_total_price
        sum = @items.map(&:price).inject(&:+)
        sum ||= create_big_decimal(0.0)
        @total_price = create_big_decimal(sum)
      end

      def recalculate_total_checkout_price
        sum = @items.map(&:checkout_price).inject(&:+)
        sum ||= create_big_decimal(0.0)
        @total_checkout_price = create_big_decimal(sum)
      end

    end
  end
end