require "spec_helper"

describe Noths::Entities::Item do

  let(:klass) { Noths::Entities::Item }
  let(:instance) { klass.new(price) }

  let(:price) { 25.69 }
  let(:checkout_price) { price }

  context "#initialize" do
    it "accepts price" do
      expect {
        klass.new(price)
      }.not_to raise_error()
    end

    it "assigns correct price" do
      expect(klass.new(price).price).to eq(price)
    end

    it "assigns correct checkout price" do
      expect(klass.new(price).checkout_price).to eq(checkout_price)
    end
  end

  context "#price" do
    it "returns current price" do
      expect(instance.price).to eq(price)
    end
  end

  context "#checkout_price" do
    it "returns current checkout price" do
      expect(instance.checkout_price).to eq(checkout_price)
    end
  end
end