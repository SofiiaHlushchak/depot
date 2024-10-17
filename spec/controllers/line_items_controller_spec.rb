# frozen_string_literal: true

require "rails_helper"

RSpec.describe LineItemsController, type: :controller do
  render_views
  login_as

  describe "POST #create" do
    let(:product) { create(:product) }

    it "creates a line item and redirects to cart" do
      expect do
        post :create, params: { product_id: product.id }
      end.to change(LineItem, :count).by(1)

      expect(response).to redirect_to(store_index_url)
    end

    it "should create line_item via turbo-stream" do
      expect do
        post :create, params: { product_id: product.id, format: :turbo_stream }
      end.to change(LineItem, :count).by(1)

      expect(response).to have_http_status(:success)
      expect(response.body).to match(/<tr class="line-item-highlight">/)
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
