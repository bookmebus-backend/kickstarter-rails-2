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
      @cart_items = current_user.cart.cart_items
      if @cart_items.empty?
        # flash[:notice] = "Please add some items to the cart before creating an order."
        redirect_to products_path 
      else
        @order = current_user.orders.build
      end
    end
  
    def create     
      @order = current_user.orders.build(order_params)
  
      if @order.save
        # Move cart items into order items
        current_user.cart.cart_items.each do |cart_item|
          @order.order_items.create(product: cart_item.product, qty: cart_item.quantity, price: cart_item.product.price)
          cart_item.destroy
        end

        # flash[:notice] = "Order created successfully"
        puts "Order created successfully"
  
        redirect_to @order, notice: "Order was successfully prepared."
      else
        puts "Error while creating order"
        puts @order.errors.full_messages
        render :new
      end
    end

    def update_status
      @order = Order.find(params[:id])
      if @order.update(order_params)
        @order.save
        flash[:notice] = 'Order status updated successfully.'
        
      else
        flash[:alert] = 'Error updating order status.'
      end
      redirect_to orders_path
    end

    # view
    def edit
        @order = Order.find_by(id: params[:id])
    end

    # action
    def update
      @order = Order.find_by(id: params[:id])
      if @order
        if @order.update(order_params)
          flash[:notice] = 'Order updated successfully.'
        else
          puts "Order errors: #{order.errors.full_messages}"
          flash[:alert] = 'Error updating order.'
        end
      else
        flash[:alert] = 'Order not found.'
      end
      redirect_to orders_path
    end

    def destroy
      @order = Order.find(params[:id])

      if @order
        @order.destroy
        flash[:notice] = 'Order deleted successfully.'
      else
        flash[:alert] = 'Order not found.'
      end
      redirect_to orders_path
    end
  
    private
  
    def order_params
      if current_user.admin?
        params.require(:order).permit(:address, :status,:price)
      else
        params.require(:order).permit(:address, :status).merge(price: calculate_total_price)
      end
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
  