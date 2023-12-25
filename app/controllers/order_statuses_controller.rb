class OrderStatusesController < ApplicationController
    before_action :authenticate_admin!
    def index
        @order_statuses = OrderStatus.all
    end

    def show 
        @order_status = OrderStatus.find(params[:id])
    end
end
