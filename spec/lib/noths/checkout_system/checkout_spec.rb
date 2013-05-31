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

  it { instance.should respond_to :checkout_rules }

  context "#initialize" do
    it "sets provided checkout rules" do
      expect(instance.checkout_rules).to eq checkout_rules
    end
  end

  context "#scan" do
    it "adds items to the basket" do
      basket.should_receive(:add_item).exactly(3).times
      scan_all_items(instance)
    end
  end

  context "#total_checkout_price" do

    it "recalculates totals" do
      scan_all_items(instance)
      expect(instance.total_checkout_price).to eq create_big_decimal(74.2)
    end

    context "when rules available" do
      let(:checkout_rules) { [rule] }
      let(:rule) { stub({}) }

      it "applies checkout rules" do
        rule.should_receive(:apply).exactly(1).times
        scan_all_items(instance)
        instance.total_checkout_price
      end
    end

    it "returns total checkout price" do

    end
  end

end