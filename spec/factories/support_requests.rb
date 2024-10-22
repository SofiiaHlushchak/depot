# frozen_string_literal: true

FactoryBot.define do
  factory :support_request do
    email { "to@example.org" }
    subject { "Test Subject" }
    body { "This is a test body for the support request." }
    association :order
  end
end
