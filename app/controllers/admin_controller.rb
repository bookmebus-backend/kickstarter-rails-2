class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @orders = Order.all
    @products = Product.all
    render :index
  end

  def update
    
  end

  private
  def authenticate_admin!
    redirect_to root_path unless current_user.admin?
  end
end
