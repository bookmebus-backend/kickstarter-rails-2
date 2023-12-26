class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_render_cart
    before_action :initialize_cart
    # before_action :set_product

    def set_render_cart
        @render_cart = true
    end

    # def set_product
    #     @products = Product.all
    # end

    # def initialize_cart
    #     @cart ||= Cart.find_by(id: session[:cart_id])
    #     if @cart.nil?
    #         @cart = Cart.create
    #         session[:cart_id] = @cart.id
    #     end
    # end
    def initialize_cart
        @cart ||= current_user&.cart || Cart.find_by(id: session[:cart_id])
        @cart ||= current_user&.create_cart
        session[:cart_id] ||= @cart&.id
    end
end
