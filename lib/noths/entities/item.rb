module Noths
  module Entities
    class Item
      attr_reader :price

      def initialize(price)
        @price = price
      end
    end
  end
end