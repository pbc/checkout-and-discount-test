module Noths
  module CheckoutSystem
    module Rules
      module DiscountRules
        class ItemQuantityFixedDiscount < BaseDiscountRule

          def initialize(params)
            @product_code = params[:product_code]
            @minimum_quantity = create_big_decimal(params[:minimum_quantity])
            @fixed_amount_discount = create_big_decimal(params[:fixed_amount_discount])
          end

          def apply(basket_object)
            if total_count_of_required_items(basket_object) >= @minimum_quantity
              apply_per_item_discount(basket_object)
            end
          end

          def is_per_item_rule?
            true
          end

          private

          def total_count_of_required_items(basket_object)
            get_required_items(basket_object).length
          end

          def product_code_matches?(item)
            item.product_code == @product_code
          end

          def get_required_items(basket_object)
            basket_object.items.select do |item|
              product_code_matches?(item)
            end
          end

          def apply_per_item_discount(basket_object)
            get_required_items(basket_object).each do |item|
              decrease_checkout_price(item)
            end
          end

          def decrease_checkout_price(item)
            item.checkout_price = item.price - create_big_decimal(@fixed_amount_discount)
          end
        end
      end
    end
  end
end
