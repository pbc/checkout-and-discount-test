module Noths
  module Providers
    class Basket
      class << self
        def instantiate
          Noths::CheckoutSystem::Basket.new
        end
      end
    end
  end
end