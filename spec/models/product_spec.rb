require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    it "must not have empty attributes" do
      product = build(:product, title: nil, description: nil, price: nil, image_url: nil)

      expect(product).to be_invalid
      expect(product.errors[:title]).to be_present
      expect(product.errors[:description]).to be_present
      expect(product.errors[:price]).to be_present
      expect(product.errors[:image_url]).to be_present
    end

    it "product price must be positive" do
      product = build(:product, price: -1)

      expect(product).to be_invalid
      expect(product.errors[:price]).to eq(["must be greater than or equal to 0.01"])

      product.price = 1
      expect(product).to be_valid
    end

    describe "image URL validations" do
      let(:valid_urls) do
        %w[
          fred.gif
          fred.jpg
          fred.png
          FRED.JPG
          FRED.Jpg
          http://a.b.c/x/y/z/fred.gif
        ]
      end

      let(:invalid_urls) do
        %w[
          fred.doc
          fred.gif/more
          fred.gif.more
        ]
      end

      it "validates image URLs" do
        valid_urls.each do |image_url|
          product = build(:product, image_url: image_url)
          expect(product).to be_valid, "#{image_url} must be valid"
        end

        invalid_urls.each do |image_url|
          product = build(:product, image_url: image_url)
          expect(product).to be_invalid, "#{image_url} must be invalid"
        end
      end
    end

    it "is not valid without a unique title" do
      create(:product, title: "unique title")

      product = build(:product, title: "unique title")

      expect(product).to be_invalid
      expect(product.errors[:title]).to include("has already been taken")
    end

    it "is not valid without a unique title  - i18n" do
      create(:product, title: "unique title")

      product = build(:product, title: "unique title")

      expect(product).to be_invalid
      expect(product.errors[:title]).to eq([I18n.t("errors.messages.taken")])
    end
  end
end
