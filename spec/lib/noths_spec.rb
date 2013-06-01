require "spec_helper"

describe Noths do
  # hard coded for the time being
  it "provides BIG_DECIMAL_PRECISION == 4" do
    expect(Noths::BIG_DECIMAL_PRECISION).to eq(4)
  end
end