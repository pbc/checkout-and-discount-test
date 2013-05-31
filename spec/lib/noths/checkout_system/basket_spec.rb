require "spec_helper"

describe Noths::CheckoutSystem::Basket do

  include Noths::Utils::NumericalOperations

  let(:instance) { Noths::CheckoutSystem::Basket.new }
  let(:item_1) { Noths::Entities::Item.new(9.25) }
  let(:item_2) { Noths::Entities::Item.new(45.00) }
  let(:item_3) { Noths::Entities::Item.new(19.95) }
  let(:items) { [item_1,item_2,item_3] }

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
    it "recalculates total price" do
      add_all_items(instance)
      instance.recalculate_total_price
      expect(instance.total_price).to eq create_big_decimal(74.2)
    end
  end

  context "#recalculate_total_checkout_price" do
    it "recalculates total checkout price" do
      add_all_items(instance)
      instance.recalculate_total_checkout_price
      expect(instance.total_checkout_price).to eq create_big_decimal(74.2)
    end
  end
end
