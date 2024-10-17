# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "MyString" }
    password { BCrypt::Password.create("secret") }
  end
end
