# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Orders", type: :system do
  include ActiveJob::TestHelper

  before do
    create(:product)
  end

  xdescribe "check dynamic fields" do
    it "shows and hides fields based on payment type" do
      visit "/"
      click_on "Add to Cart", match: :first
      click_on "Checkout"

      expect(page).not_to have_field("Routing number")
      expect(page).not_to have_field("Account number")
      expect(page).not_to have_field("Credit card number")
      expect(page).not_to have_field("Expiration date")
      expect(page).not_to have_field("Po number")

      select "Check", from: "Pay type"
      expect(page).to have_field("Routing number")
      expect(page).to have_field("Account number")
      expect(page).not_to have_field("Credit card number")
      expect(page).not_to have_field("Expiration date")
      expect(page).not_to have_field("Po number")

      select "Credit card", from: "Pay type"
      expect(page).not_to have_field("Routing number")
      expect(page).not_to have_field("Account number")
      expect(page).to have_field("Credit card number")
      expect(page).to have_field("Expiration date")
      expect(page).not_to have_field("Po number")

      select "Purchase order", from: "Pay type"
      expect(page).not_to have_field("Routing number")
      expect(page).not_to have_field("Account number")
      expect(page).not_to have_field("Credit card number")
      expect(page).not_to have_field("Expiration date")
      expect(page).to have_field("Po number")
    end
  end

  xdescribe "placing an order" do
    before do
      LineItem.delete_all
      Order.delete_all
    end

    it "successfully places an order and sends a confirmation email" do
      visit "/"
      click_on "Add to Cart", match: :first
      click_on "Checkout"

      fill_in "Name", with: "Dave Thomas"
      fill_in "Address", with: "123 Main Street"
      fill_in "Email", with: "dave@example.com"
      select "Check", from: "Pay type"

      fill_in "Routing number", with: "123456"
      fill_in "Account number", with: "987654"
      click_button "Place Order"

      expect(page).to have_text("Thank you for your order")

      perform_enqueued_jobs
      perform_enqueued_jobs

      expect(Order.count).to eq(1)
      order = Order.first

      expect(order.name).to eq("Dave Thomas")
      expect(order.address).to eq("123 Main Street")
      expect(order.email).to eq("dave@example.com")
      expect(order.pay_type).to eq("Check")
      expect(order.line_items.size).to eq(1)

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq(["dave@example.com"])
      expect(mail.from).to eq(["depot@example.com"])
      expect(mail.subject).to eq("Pragmatic Store Order Confirmation")
    end
  end
end
