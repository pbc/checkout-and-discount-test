module Noths
  module Utils
    module NumericalOperations
      def create_big_decimal(value)
        ::BigDecimal.new(value, Noths::BIG_DECIMAL_PRECISION)
      end
    end
  end
end