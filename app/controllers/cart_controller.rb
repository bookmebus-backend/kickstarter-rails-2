class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    @cart = current_user.cart
    quantity = params[:quantity].to_i
    current_cart_item = @cart.cart_items.find_by(product_id: @product.id)
    
    if current_cart_item && quantity > 0
      current_cart_item.update(quantity:)
    elsif quantity <= 0
      current_cart_item.destroy
    else
      @cart.cart_items.create(product: @product, quantity:)
    end
    # respond_to do |format|
    #   format.turbo_stream do
    #     render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart}),
    #                           turbo_stream.replace(@product),
    #                          ]
    #   end
    # end
    redirect_to products_path, notice: 'Product added to cart successfully.'
  end

  def remove
    current_user.cart.cart_items.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart})
      end
    end
  end
end
