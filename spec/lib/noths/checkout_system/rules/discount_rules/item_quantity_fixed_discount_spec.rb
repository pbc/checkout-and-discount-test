require "spec_helper"
require "ostruct"

describe Noths::CheckoutSystem::Rules::DiscountRules::
           ItemQuantityFixedDiscount do

  let(:rules_module) { ::Noths::CheckoutSystem::Rules::DiscountRules }

  let(:instance) {
    rules_module::ItemQuantityFixedDiscount.new(discount_options)
  }
  let(:discount_options) {
    {
      :product_code => "001",
      :minimum_quantity => 2,
      :fixed_amount_discount => 0.75
    }
  }
  let(:basket) {
    OpenStruct.new(:items => items)
  }

  let(:item_1) { EntityFixtures::Item.item_1 }
  let(:item_3) { EntityFixtures::Item.item_3 }

  let(:items) { [item_1,item_3,item_1] }

  context "#apply" do
    context "total count of required items >= minimum quantity" do
      it "applies per item discount to all required items" do
        instance.apply(basket)
        expect(basket.items[0].checkout_price.to_s).to eq("8.5")
        expect(basket.items[1].checkout_price.to_s).to eq("19.95")
        expect(basket.items[2].checkout_price.to_s).to eq("8.5")
      end
    end
  end
end