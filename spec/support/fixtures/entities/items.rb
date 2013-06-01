module EntityFixtures
  class Item
    class << self
      def item_1
        klass.new(default_params.merge(
          {
            :product_code => "001",
            :name => "Travel Card Holder",
            :price => 9.25,
            :checkout_price => 9.25
          }
        ))
      end

      def item_2
        klass.new(default_params.merge(
          {
            :product_code => "002",
            :name => "Personalised cufflinks",
            :price => 45.0,
            :checkout_price => 45.0
          }
        ))
      end

      def item_3
        klass.new(default_params.merge(
          {
            :product_code => "003",
            :name => "Kids T-shirt",
            :price => 19.95,
            :checkout_price => 19.95
          }
        ))
      end

      private

      def default_params
        {
          :product_code => "",
          :name => "",
          :price => 1.0,
          :checkout_price => 1.0
        }
      end

      def klass
        Noths::Entities::Item
      end

    end
  end
end
