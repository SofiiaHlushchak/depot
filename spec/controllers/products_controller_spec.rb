require 'rails_helper'

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
      expect {
        post :create, params: { product: valid_attributes }
      }.to change(Product, :count).by(1)
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
end
