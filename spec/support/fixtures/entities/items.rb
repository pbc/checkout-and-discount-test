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
  #item_1) {  }
  #let(:item_2) { Noths::Entities::Item.new(45.00) }
  #let(:item_3) { Noths::Entities::Item.new(19.95) }
  #let(:items) { [item_1,item_2,item_3] }
  #
  #let(:params_1) {
  #  {
  #    :product_code => product_code,
  #    :name => name,
  #    :price => price,
  #    :checkout_price => checkout_price
  #  }
  #}
  #
  #let(:product_code) { "001" }
  #let(:name) { "Foo Bar" }
  #let(:price) { 25.69 }
  #let(:checkout_price) { price }