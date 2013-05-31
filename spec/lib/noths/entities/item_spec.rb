require "spec_helper"

describe Noths::Entities::Item do

  let(:klass) { Noths::Entities::Item }
  let(:instance) { klass.new(price) }

  let(:price) { 25.69 }

  context "#initializer" do
    it "accepts price" do
      expect {
        klass.new(price)
      }.not_to raise_error()
    end

    it "assigns correct price" do
      expect(klass.new(price).price).to eq(price)
    end
  end

  context "#price" do
    it "returns price current price" do
      expect(instance.price).to eq(price)
    end
  end
end