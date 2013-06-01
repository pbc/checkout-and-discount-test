module Noths
  module CheckoutSystem
    module Rules
      class BaseDiscountRule
        include Noths::Utils::NumericalOperations

        def apply(basket_object)
        end

        def is_per_item_rule?
          false
        end

        def is_per_total_rule?
          false
        end
      end
    end
  end
end