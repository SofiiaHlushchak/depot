# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  render_views

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) do
        { name: "New Order", address: "123 Main St", email: "test@example.com", pay_type: "Credit card" }
      end

      it "creates a new Order" do
        expect do
          post :create, params: { order: valid_attributes }
        end.to change(Order, :count).by(1)
      end

      it "redirects to the created order" do
        post :create, params: { order: valid_attributes }
        expect(response).to redirect_to(store_index_url(locale: "en"))
      end
    end
  end

  describe "GET #new" do
    context "when the cart is empty" do
      it "redirects to the store index with a notice" do
        get :new

        expect(response).to redirect_to(store_index_path)
        expect(flash[:notice]).to eq("Your cart is empty")
      end
    end

    context "when the cart is not empty" do
      before do
        line_item = create(:line_item)

        session[:cart_id] = line_item.cart_id
      end

      it "returns a success response" do
        get :new

        expect(response).to be_successful
      end
    end
  end
end
