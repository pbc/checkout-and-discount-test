module Noths
  module CheckoutSystem
    module Rules
      module DiscountRules
        class TotalAmountPercentageDiscount < BaseDiscountRule

          def initialize(total_price_limit, discount_percentage)
            @total_price_limit = create_big_decimal(total_price_limit)
            @discount_percentage = create_big_decimal(discount_percentage)
          end

          def apply(basket_object)
            if basket_object.total_price > @total_price_limit
              apply_discount(basket_object)
            end
          end

          def is_per_total_rule?
            true
          end

          private

          def apply_discount(basket_object)
            basket_object.total_checkout_price = basket_object.total_checkout_price * descount_multiplier
          end

          def descount_multiplier
            (create_big_decimal(100.0) - @discount_percentage)  / create_big_decimal(100.0)
          end
        end
      end
    end
  end
end
