# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Orders", type: :system do
  xdescribe "check dynamic fields" do
    before do
      create(:product)
    end

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
end
