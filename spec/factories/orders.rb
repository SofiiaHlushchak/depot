# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    name { "Dave Thomas" }
    address { "MyText" }
    email { "dave@example.org" }
    pay_type { "Credit card" }
  end
end
