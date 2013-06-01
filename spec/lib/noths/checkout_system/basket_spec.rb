require "spec_helper"

describe Noths::CheckoutSystem::Basket do

  include Noths::Utils::NumericalOperations

  let(:instance) { Noths::CheckoutSystem::Basket.new }
  let(:item_1) { EntityFixtures::Item.item_1 }
  let(:item_2) { EntityFixtures::Item.item_2 }
  let(:item_3) { EntityFixtures::Item.item_3 }
  let(:items) { [item_1,item_2,item_3] }

  let(:params_1) {
    {
      :product_code => product_code,
      :name => name,
      :price => price,
      :checkout_price => checkout_price
    }
  }

  let(:product_code) { "001" }
  let(:name) { "Foo Bar" }
  let(:price) { 25.69 }
  let(:checkout_price) { price }

  def add_all_items(inst)
    items.each do |itm|
      inst.add_item(itm)
    end
  end

  it { instance.should respond_to :items }

  context "#items" do
    it "returns empty array by default" do
      expect(instance.items).to eq([])
    end
  end

  context "#add_item" do
    it "adds items to the items collection" do
      add_all_items(instance)
      expect(instance.items).to eq(items)
    end
  end

  context "#total_price" do
    it "returns by default BigDecimal == 0.0" do
      expect(instance.total_price).to be_a(BigDecimal)
      expect(instance.total_price).to eq 0.0
    end
  end

  context "#total_checkout_price" do
    it "returns by default BigDecimal == 0.0" do
      expect(instance.total_checkout_price).to be_a(BigDecimal)
      expect(instance.total_checkout_price).to eq 0.0
    end
  end

  context "#total_checkout_price=" do
    it "converts value to BigDecimal" do
      instance.total_checkout_price = 5.23
      expect(instance.total_checkout_price).to eq create_big_decimal(5.23)
    end
  end

  context "#reset_item_checkout_prices" do
    it "all item checkout prices should match their respective 'price' " do
      add_all_items(instance)
      item_1.should_receive(:reset_checkout_price).exactly(1).times
      item_2.should_receive(:reset_checkout_price).exactly(1).times
      item_3.should_receive(:reset_checkout_price).exactly(1).times
      instance.reset_item_checkout_prices
    end
  end

  context "#recalculate_totals" do
    before do
      expect(instance.total_price).to eq create_big_decimal(0.0)
      expect(instance.total_checkout_price).to eq create_big_decimal(0.0)
    end

    it "recalculates total price" do
      add_all_items(instance)
      instance.recalculate_totals
      expect(instance.total_price).to eq create_big_decimal(74.2)
    end

    it "recalculates total checkout price" do
      add_all_items(instance)
      instance.recalculate_totals
      expect(instance.total_checkout_price).to eq create_big_decimal(74.2)
    end
  end

  context "#recalculate_total_price" do
    context "no items in the basket" do
      it "recalculates total price" do
        instance.recalculate_total_price
        expect(instance.total_price).to eq create_big_decimal(0.0)
      end
    end

    context "when items are in the basket" do
      it "recalculates total price" do
        add_all_items(instance)
        instance.recalculate_total_price
        expect(instance.total_price).to eq create_big_decimal(74.2)
      end
    end
  end

  context "#recalculate_total_checkout_price" do
    context "no items in the basket" do
      it "recalculates total checkout price correctly" do
        instance.recalculate_total_checkout_price
        expect(instance.total_checkout_price).to eq create_big_decimal(0.0)
      end
    end

    context "when items are in the basket" do
      it "recalculates total checkout price" do
        add_all_items(instance)
        instance.recalculate_total_checkout_price
        expect(instance.total_checkout_price).to eq create_big_decimal(74.2)
      end
    end
  end
end
