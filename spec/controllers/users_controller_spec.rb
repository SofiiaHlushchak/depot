# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    before do
      create(:user)
    end

    it "returns a successful response" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      expect do
        post :create, params: { user: { name: "user", password: "test" } }
      end.to change(User, :count).by(1)

      expect(response).to redirect_to(users_url)
    end
  end

  describe "PATCH #update" do
    let!(:user) { create(:user) }

    it "updates an existing user" do
      patch :update, params: { id: user.id, user: { name: "Updated User" } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(users_url)

      user.reload
      expect(user.name).to eq("Updated User")
    end
  end
end
