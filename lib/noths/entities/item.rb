module Noths
  module Entities
    class Item
      attr_accessor :product_code
      attr_accessor :name
      attr_accessor :price
      attr_accessor :checkout_price

      def initialize(params)
        @product_code = params[:product_code]
        @name = params[:name]
        @price = params[:price]
        @checkout_price = params[:checkout_price]
      end

      def reset_checkout_price
        @checkout_price = 0 + @price
      end
    end
  end
end