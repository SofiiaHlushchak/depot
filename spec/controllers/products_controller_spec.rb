# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let(:valid_attributes) do
    {
      title: "My Product",
      description: "A great product",
      price: 9.99,
      image_url: "http://example.com/image.jpg"
    }
  end

  describe "POST /create" do
    it "creates a new product" do
      expect do
        post :create, params: { product: valid_attributes }
      end.to change(Product, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH /update" do
    let(:product) { create(:product) }
    it "updates an existing product" do
      patch :update, params: { id: product.id, product: { title: "Updated Product" } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(product_url(product))
      product.reload
      expect(product.title).to eq("Updated Product")
    end
  end

  describe "DELETE #destroy" do
    let!(:product_in_cart) { create(:product, title: "QWE") }
    let!(:cart_with_product) { create(:cart) }
    let!(:line_item) { create(:line_item, product: product_in_cart, cart: cart_with_product) }

    context "when product is in a cart" do
      it "can't delete product in cart" do
        expect do
          delete :destroy, params: { id: product_in_cart.id }
        end.not_to change(Product, :count)

        expect(response).to redirect_to(products_url)
      end
    end

    context "when product is not in a cart" do
      let!(:product_not_in_cart) { create(:product, title: "ASD") }

      it "should destroy product" do
        expect do
          delete :destroy, params: { id: product_not_in_cart.id }
        end.to change(Product, :count).by(-1)

        expect(response).to redirect_to(products_url)
      end
    end
  end
end
