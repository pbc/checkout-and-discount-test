require "spec_helper"

describe Noths::CheckoutSystem::Checkout do

  let(:rules_module) { ::Noths::CheckoutSystem::Rules }

  let(:instance) { Noths::CheckoutSystem::Checkout.new(checkout_rules) }
  let(:checkout_rules) { [per_total_rule, per_item_rule] }
  let(:per_item_rule) { stub({
    is_per_item_rule?: true,
    is_per_total_rule?: false
  }).as_null_object }

  let(:per_total_rule) { stub({
    is_per_item_rule?: false,
    is_per_total_rule?: true
  }).as_null_object }


  let(:item_1) { EntityFixtures::Item.item_1 }
  let(:item_2) { EntityFixtures::Item.item_2 }
  let(:item_3) { EntityFixtures::Item.item_3 }
  let(:items) { [item_1,item_2,item_3] }

  let(:basket) { stub({
    :total_checkout_price => basket_total_checkout_price
  }).as_null_object }
  let(:basket_total_checkout_price) {}

  include Noths::Utils::NumericalOperations

  before do
    Noths::Providers::Basket.stub(:instantiate).and_return(basket)
  end

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

    it "applies per item checkout rules to the basket" do
      per_item_rule.should_receive(:apply).exactly(3).times
      scan_all_items(instance)
    end

    it "applies per total checkout rules to the basket" do
      per_total_rule.should_receive(:apply).exactly(3).times
      scan_all_items(instance)
    end

    it "it asks basket to recalculate totals" do
      basket.should_receive(:recalculate_totals).exactly(6).times
      scan_all_items(instance)
    end

    it "resets item checkout prices" do
      basket.should_receive(:reset_item_checkout_prices).exactly(3).times
      scan_all_items(instance)
    end
  end

  context "#total" do
    it "returns basket's total_checkout_price" do
      expect(instance.total).to eq basket_total_checkout_price
    end
  end

end

