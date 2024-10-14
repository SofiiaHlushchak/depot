# frozen_string_literal: true

require "rails_helper"

RSpec.describe CartsController, type: :controller do
  describe "DELETE #destroy" do
    let!(:cart) { create(:cart) }
    let!(:product) { create(:product) }

    before do
      session[:cart_id] = cart.id
      post :create, params: { line_item: { product_id: product.id } }
    end

    it "should destroy cart" do
      expect do
        delete :destroy, params: { id: cart.id }
      end.to change(Cart, :count).by(-1)

      expect(response).to redirect_to(store_index_url)
      expect(flash[:notice]).to eq("Your cart is currently empty.")
    end
  end
end
