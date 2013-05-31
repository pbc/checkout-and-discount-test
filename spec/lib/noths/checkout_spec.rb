require "spec_helper"

describe Noths::Checkout do

  let(:instance) { Noths::Checkout.new }
  let(:item_1) { Noths::Entities::Item.new(9.34) }
  let(:item_2) { Noths::Entities::Item.new(45.00) }
  let(:item_3) { Noths::Entities::Item.new(19.95) }
  let(:items) { [item_1,item_2,item_3] }

  context "#scan" do
    it "scans the items" do
      expect {
        instance.scan(item_1)
        instance.scan(item_2)
      }.not_to raise_error()
    end
  end


  context "#items" do
    it "keeps the list of scanned items" do
      instance.scan(item_1)
      instance.scan(item_2)
      instance.scan(item_3)
      expect(instance.items).to eq(items)
    end
  end



  #context "no additional checkout rules" do
  #  it "provides total price of scanned items" do
  #    instance.scan(item_1)
  #    expect(instance.total).not_to raise_error()
  #  end
  #end
end