require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  let(:product) { create(:product) }

  describe "POST #create" do
    it "creates a line item and redirects to cart" do
      expect {
        post :create, params: { product_id: product.id }
      }.to change(LineItem, :count).by(1)

      expect(response).to redirect_to(cart_url(assigns(:line_item).cart))
    end
  end
end
