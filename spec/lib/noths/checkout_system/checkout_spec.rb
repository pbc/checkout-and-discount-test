require "spec_helper"

describe Noths::CheckoutSystem::Checkout do

  let(:rules_module) { ::Noths::CheckoutSystem::Rules }

  let(:instance) { Noths::CheckoutSystem::Checkout.new(checkout_rules) }
  let(:item_1) { Noths::Entities::Item.new(9.25) }
  let(:item_2) { Noths::Entities::Item.new(45.00) }
  let(:item_3) { Noths::Entities::Item.new(19.95) }
  let(:items) { [item_1,item_2,item_3] }
  let(:bundle_rules) {[]}
  let(:total_rules) {[]}
  let(:checkout_rules) { bundle_rules + total_rules}

  include Noths::Utils::NumericalOperations

  def item_total_price(items)
    sum = items.map(&:price).inject(&:+)
    create_big_decimal(sum)
  end

  def item_total_checkout_price(items)
    sum = items.map(&:checkout_price).inject(&:+)
    create_big_decimal(sum)
  end

  def scan_all_items(checkout)
    checkout.scan(item_1)
    checkout.scan(item_2)
    checkout.scan(item_3)
  end

  context "#initialize" do
    it "sets provided checkout rules" do
      expect(instance.checkout_rules).to eq checkout_rules
    end
  end

  context "#scan" do
    it "scans the items" do
      expect {
        scan_all_items(instance)
      }.not_to raise_error()
    end
  end

  context "#items" do
    it "keeps the list of scanned items" do
      scan_all_items(instance)
      expect(instance.items).to eq items
    end
  end

  context "#total_price" do
    context "no additional checkout rules" do
      it "provides correct total price of scanned items" do
        scan_all_items(instance)
        expect(instance.total_price).to eq item_total_price(items)
      end
    end

    context "with additional checkout rules" do
      it "provides correct total price of scanned items" do
        scan_all_items(instance)
        expect(instance.total_price).to eq item_total_price(items)
      end
    end
  end

  context "#total_checkout_price" do
    context "no additional checkout rules" do
      it "provides correct total checkout price of scanned items" do
        scan_all_items(instance)
        expect(instance.total_checkout_price).to eq item_total_checkout_price(items)
      end

      it "matches unmodified total price" do
        scan_all_items(instance)
        expect(instance.total_checkout_price).to eq instance.total_price
      end
    end

    context "with TotalAmountPercentageDiscount" do
      let(:total_amount_percentage_discount) {
        rules_module::DiscountRules::TotalAmountPercentageDiscount.new(
          total_price_limit, discount_percentage
        )
      }
      let(:checkout_rules) { [total_amount_percentage_discount]}
      let(:total_price_limit) { 60.00 }
      let(:discount_percentage) { 10.0 }
      let(:total_checkout_price) { create_big_decimal(66.78) }

      it "calculates checkout price correctly" do
        scan_all_items(instance)
        expect(instance.total_checkout_price.to_f).to eq(total_checkout_price.to_f)
      end
    end
  end
end