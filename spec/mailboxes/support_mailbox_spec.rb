# frozen_string_literal: true

require "rails_helper"

RSpec.describe SupportMailbox, type: :mailbox do
  describe "support emails" do
    it "creates a SupportRequest when we receive a support email" do
      receive_inbound_email_from_mail(
        to: "support@example.com",
        from: "chris@somewhere.net",
        subject: "Need help",
        body: "I can't figure out how to check out!!"
      )

      support_request = SupportRequest.last

      expect(support_request.email).to eq("chris@somewhere.net")
      expect(support_request.subject).to eq("Need help")
      expect(support_request.body).to eq("I can't figure out how to check out!!")
      expect(support_request.order).to be_nil
    end
  end

  describe "support emails" do
    let!(:recent_order) { create(:order, email: "dave@example.org", created_at: 1.day.ago) }
    let!(:older_order) { create(:order, email: "dave@example.org", created_at: 2.days.ago) }
    let(:non_customer_email) { "noncustomer@nowhere.net" }

    it "creates a SupportRequest with the most recent order" do
      receive_inbound_email_from_mail(
        to: "support@example.com",
        from: recent_order.email,
        subject: "Need help",
        body: "I can't figure out how to check out!!"
      )

      support_request = SupportRequest.last

      expect(support_request.email).to eq(recent_order.email)
      expect(support_request.subject).to eq("Need help")
      expect(support_request.body).to eq("I can't figure out how to check out!!")
      expect(support_request.order).to eq(recent_order)
    end

    it "does not associate an order if no recent order exists" do
      receive_inbound_email_from_mail(
        to: "support@example.com",
        from: non_customer_email,
        subject: "Need help",
        body: "I can't figure out how to check out!!"
      )

      support_request = SupportRequest.last

      expect(support_request.email).to eq(non_customer_email)
      expect(support_request.subject).to eq("Need help")
      expect(support_request.body).to eq("I can't figure out how to check out!!")
      expect(support_request.order).to be_nil
    end
  end
end
