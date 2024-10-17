# frozen_string_literal: true

require "rails_helper"

RSpec.describe AdminController, type: :controller do
  login_as

  describe "GET #index" do
    it "returns a successful response" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end
end
