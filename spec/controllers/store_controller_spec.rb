# frozen_string_literal: true

require "rails_helper"

RSpec.describe StoreController, type: :controller do
  describe "GET #index" do
    before do
      create(:product)
    end

    it "returns a successful response" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end
end
