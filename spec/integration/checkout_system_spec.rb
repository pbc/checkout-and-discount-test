require "spec_helper"
require "support/fixtures/entities/items"

describe "checkout system integration" do

  let(:rules_module) { ::Noths::CheckoutSystem::Rules }

  let(:checkout) { Noths::CheckoutSystem::Checkout.new(checkout_rules) }
  let(:rules_module) { ::Noths::CheckoutSystem::Rules::DiscountRules }

  let(:total_amount_percentage_discount) {
    rules_module::TotalAmountPercentageDiscount.new(
      total_price_limit, discount_percentage
    )
  }

  let(:total_price_limit) { 60.00 }
  let(:discount_percentage) { 10.0 }

  let(:item_quantity_fixed_discount) {
    rules_module::ItemQuantityFixedDiscount.new(fixed_discount_options)
  }
  let(:fixed_discount_options) {
    {
      :product_code => "001",
      :minimum_quantity => 2,
      :fixed_amount_discount => 0.75
    }
  }

  let(:checkout_rules) { [] }

  let(:item_1) { EntityFixtures::Item.item_1 }
  let(:item_2) { EntityFixtures::Item.item_2 }
  let(:item_3) { EntityFixtures::Item.item_3 }
  let(:items) { [item_1,item_2,item_3] }

  include Noths::Utils::NumericalOperations

  def item_total_price(items)
    sum = items.map(&:price).inject(&:+)
    create_big_decimal(sum)
  end

  def item_total_checkout_price(items)
    sum = items.map(&:checkout_price).inject(&:+)
    create_big_decimal(sum)
  end

  def scan_all_items(checkout_object)
    checkout_object.scan(item_1)
    checkout_object.scan(item_2)
    checkout_object.scan(item_3)
  end

  context "discount rules application" do

    context "single total amount percentage discount" do

      let(:checkout_rules) { [total_amount_percentage_discount] }

      it "applies the discount correctly" do
        scan_all_items(checkout)
        expect(checkout.total).to eq create_big_decimal(66.78)
      end
    end


    context "single item quantity fixed discount" do

      let(:checkout_rules) { [item_quantity_fixed_discount] }

      it "applies item quantity fixed discount correctly" do
        checkout.scan(item_1)
        checkout.scan(item_3)
        checkout.scan(item_1)
        expect(checkout.total).to eq create_big_decimal(36.95)
      end

    end

    context "single item quantity fixed discount" +
            "with single total amount percentage discount" do

      let(:checkout_rules) { [item_quantity_fixed_discount,
                              total_amount_percentage_discount] }

      context "only total amount discount applies" do
        it "applies the discount correctly" do
          scan_all_items(checkout)
          expect(checkout.total).to eq create_big_decimal(66.78)
        end
      end

      context "only item quantity discount applies" do
        it "applies the discount correctly" do
          checkout.scan(item_1)
          checkout.scan(item_3)
          checkout.scan(item_1)
          expect(checkout.total).to eq create_big_decimal(36.95)
        end
      end

      context "both discounts apply" do
        it "applies all discounts correctly" do
          checkout.scan(item_1)
          checkout.scan(item_2)
          checkout.scan(item_1)
          checkout.scan(item_3)
          expect(checkout.total.round(2)).to eq create_big_decimal(73.76)
        end
      end

    end
  end
end