module Noths
  module Entities
    class Item
      attr_reader :price
      attr_reader :checkout_price

      def initialize(price)
        @price = price
        @checkout_price = price
      end
    end
  end
end