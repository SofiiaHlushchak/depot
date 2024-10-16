# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  describe "received" do
    let(:mail) { OrderMailer.received(create(:order)) }

    it "renders the headers" do
      expect(mail.subject).to eq("Pragmatic Store Order Confirmation")
      expect(mail.to).to eq(["dave@example.org"])
      expect(mail.from).to eq(["depot@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Dear Dave Thomas")
    end
  end

  describe "shipped" do
    let(:mail) { OrderMailer.shipped(create(:order)) }

    it "renders the headers" do
      expect(mail.subject).to eq("Pragmatic Store Order Shipped")
      expect(mail.to).to eq(["dave@example.org"])
      expect(mail.from).to eq(["depot@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("This is just to let you know that we've shipped your recent order:")
    end
  end
end
