require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  describe "POST #create" do
    let(:product) { create(:product) }

    it "creates a line item and redirects to cart" do
      expect {
        post :create, params: { product_id: product.id }
      }.to change(LineItem, :count).by(1)

      expect(response).to redirect_to(cart_url(assigns(:line_item).cart))
    end
  end

  describe "PATCH /line_items/:id" do
    let!(:line_item) { create(:line_item) }
    let(:product) { create(:product, title: "ASD") }

    it "should update line_item" do
      patch :update, params: { id: line_item.id, line_item: { product_id: product.id } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(line_item_url(line_item))

      line_item.reload
      expect(line_item.product_id).to eq(product.id)
    end
  end
end
