class OrdersController < ApplicationController
    before_action :authenticate_user!, only: :index
    before_action :check_admin, only: :index
  
    def index
        if @is_admin
            @orders = Order.all
            render :index
        end
      @orders = current_user.orders
    end

    def admin_index
        @orders = Order.all
        render :index
    end
  
    def show
      @order = current_user.orders.find(params[:id])
    end
  
    def new 
      @order = current_user.orders.build
      @cart_items = current_user.cart.cart_items
    end
  
    def create
      @order = current_user.orders.build(order_params)
  
      if @order.save
        # Move cart items into order items
        current_user.cart.cart_items.each do |cart_item|
          @order.order_items.create(product: cart_item.product, qty: cart_item.quantity, price: cart_item.product.price)
          cart_item.destroy
        end

        puts "Order created successfully"
  
        redirect_to @order, alert: "Order was successfully prepared."
      else
        puts "Error while creating order"
        puts @order.errors.full_messages
        render :new
      end
    end
  
    private
  
    def order_params
      params.require(:order).permit(:address).merge(price: calculate_total_price)
    end
  
    def calculate_total_price
      current_user.cart.cart_items.sum { |cart_item| cart_item.product.price * cart_item.quantity }
    end

    def check_admin
        if current_user.role == "admin"
        @is_admin = true
        end
    end
  end
  