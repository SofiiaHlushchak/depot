# frozen_string_literal: true

require "rails_helper"

RSpec.describe SupportRequestMailer, type: :mailer do
  describe "respond" do
    let(:support_request) { create(:support_request) }
    let(:mail) { SupportRequestMailer.respond(support_request) }

    it "renders the headers" do
      expect(mail.subject).to eq("Re: #{support_request.subject}")
      expect(mail.to).to eq([support_request.email])
      expect(mail.from).to eq(["support@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(support_request.body)
    end
  end
end
