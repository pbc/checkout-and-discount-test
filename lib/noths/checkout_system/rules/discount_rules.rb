module Noths
  module CheckoutSystem
    module Rules
      module DiscountRules
      end
    end
  end
end

require_relative "discount_rules/base_discount_rule"
require_relative "discount_rules/total_amount_percentage_discount"