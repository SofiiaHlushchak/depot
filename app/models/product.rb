# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :line_items, dependent: :restrict_with_error

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\z/i,
    message: "must be a URL for GIF, JPG or PNG image."
  }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  before_destroy :ensure_not_referenced_by_any_line_item

  private
  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, "Line Items present")
    throw :abort
  end
end
