require "spec_helper"

describe Noths::Utils::NumericalOperations do
  class TestContainer
    class << self
      include Noths::Utils::NumericalOperations
    end
  end

  let(:precision) { Noths::BIG_DECIMAL_PRECISION }

  context "included" do
    context "#create_big_decimal" do
      it "allows to create big decimals with globaly specified precision" do
        Noths.stub(:BIG_DECIMAL_PRECISION => 5)
        expect(TestContainer.create_big_decimal(2.36)).to eq ::BigDecimal.new(2.36, precision)
        Noths.stub(:BIG_DECIMAL_PRECISION => 3)
        expect(TestContainer.create_big_decimal(2.36)).to eq ::BigDecimal.new(2.36, precision)
      end
    end
  end


end