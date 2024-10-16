# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    name { "MyString" }
    address { "MyText" }
    email { "MyString" }
    pay_type { Order.pay_types.keys.sample }
  end
end
