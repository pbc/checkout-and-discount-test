module Noths
  module CheckoutSystem
    module Rules
      module DiscountRules
        class TotalAmountPercentageDiscount < BaseDiscountRule

          def initialize(total_price_limit, discount_percentage)
            @total_price_limit = create_big_decimal(total_price_limit)
            @discount_percentage = create_big_decimal(discount_percentage)
          end

          def apply(checkout_object)
            if checkout_object.total_price > @total_price_limit
              apply_discount(checkout_object)
            end
          end

          private

          def apply_discount(checkout_object)
            checkout_object.total_checkout_price = checkout_object.total_checkout_price * descount_multiplier
          end

          def descount_multiplier
            (create_big_decimal(100.0) - @discount_percentage)  / create_big_decimal(100.0)
          end
        end
      end
    end
  end
end
