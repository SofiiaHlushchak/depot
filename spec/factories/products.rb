# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { "My Book Title" }
    description { "A description of the book." }
    image_url { "http://example.com/image.jpg" }
    price { 9.99 }

    trait :invalid do
      title { nil }
      price { -1 }
      image_url { "invalid_image.doc" }
    end
  end
end
