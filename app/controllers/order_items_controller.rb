class OrderItemsController < ApplicationController
    before_action :authenticate_admin!

    def index
        @order_items = OrderItem.all
    end

    def show
        @order_item = OrderItem.find(params[:id])
    end
end
