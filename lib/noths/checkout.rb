require "bigdecimal"

module Noths
  class Checkout

    include Noths::Utils::NumericalOperations

    attr_reader :total
    attr_reader :items

    def initialize
      @total = create_big_decimal(0.0)
      @items = []
    end

    def scan(item)
      @items << item
    end

    def total
      sum = @items.map(&:price).inject(&:+)
      create_big_decimal(sum)
    end

  end
end