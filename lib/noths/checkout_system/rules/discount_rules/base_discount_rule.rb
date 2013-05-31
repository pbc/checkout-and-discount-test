module Noths
  module CheckoutSystem
    module Rules
      class BaseDiscountRule
        include Noths::Utils::NumericalOperations

        def apply_discount
        end
      end
    end
  end
end