class Admin::DashboardController < ApplicationController
  def show
    @products = Product.order(:id).all
    @categories = Category.order(:id)
  end
end
