# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "prompts for login" do
      get :new

      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }

    it "logs in the user" do
      post :create, params: { name: user.name, password: user.password }

      expect(response).to redirect_to(admin_url)
      expect(session[:user_id]).to eq(user.id)
    end

    it "fails to log in with wrong password" do
      post :create, params: { name: user.name, password: "wrong" }

      expect(response).to redirect_to(login_url)
    end
  end

  describe "DELETE #destroy" do
    it "logs out the user" do
      delete :destroy

      expect(response).to redirect_to(store_index_url)
    end
  end
end
