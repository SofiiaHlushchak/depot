FactoryBot.define do
  factory :line_item do
    association :product, factory: :product
    association :cart, factory: :cart
    quantity { 1 }
  end
end
