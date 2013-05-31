module Noths
  module Providers
    class Item
      class << self
        def find_by_id(id)
          # faking the provider for the time being
          Noths::Entities::Item.new(123.45)
        end
      end
    end
  end
end