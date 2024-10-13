class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    update_counter
    @products = Product.order(:title)
  end

  private

  def update_counter
    session[:counter] = (session[:counter] || 0) + 1
  end
end
