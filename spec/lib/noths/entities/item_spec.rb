require "spec_helper"

describe Noths::Entities::Item do

  include Noths::Utils::NumericalOperations

  let(:klass) { Noths::Entities::Item }
  let(:instance) { klass.new(params) }

  let(:params) {
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
  let(:checkout_price) { 26.66 }

  context "#initialize" do
    it "assigns correct product code" do
      expect(instance.product_code).to eq(product_code)
    end

    it "assigns correct name" do
      expect(instance.name).to eq(name)
    end

    it "assigns correct price" do
      expect(instance.price).to eq(price)
    end

    it "assigns correct checkout price" do
      expect(instance.checkout_price).to eq(checkout_price)
    end
  end

  context "#reset_checkout_price" do
    it "sets the checkout price to value of price" do
      instance.checkout_price = 2.56
      instance.reset_checkout_price
      expect(instance.checkout_price).to eq 25.69
    end
  end
end