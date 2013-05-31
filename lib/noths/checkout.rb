require "bigdecimal"

module Noths
  class Checkout
    attr_reader :total
    attr_reader :items

    def initialize
      @total = ::BigDecimal.new(0.0, Noths::BIG_DECIMAL_PRECISION)
      @items = []
    end

    def scan(item)
      @items << item
    end

  end
end