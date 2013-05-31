require "spec_helper"
require "ostruct"

describe Noths::CheckoutSystem::Rules::DiscountRules::
           TotalAmountPercentageDiscount do

  let(:rules_module) { ::Noths::CheckoutSystem::Rules::DiscountRules }

  let(:instance) {
    rules_module::TotalAmountPercentageDiscount.new(
      total_price_limit, discount_percentage
    )
  }
  let(:total_price_limit) { 60.00 }
  let(:discount_percentage) { 10.0 }
  let(:checkout_object) {
    OpenStruct.new(:total_price => total_price, :total_checkout_price => total_price)
  }

  let(:total_price) { 74.2 }

  context "#apply" do
    context "checkout object's price > total price limit" do
      it "applies percentage discount" do
        instance.apply(checkout_object)
        expect(checkout_object.total_checkout_price.to_s).to eq("66.78")
      end
    end

    context "checkout object's price <= total price limit" do
      let(:total_price) { 52.2 }
      it "doesn't apply the discount" do
        instance.apply(checkout_object)
        expect(checkout_object.total_checkout_price.to_s).to eq("#{total_price}")
      end
    end
  end
end