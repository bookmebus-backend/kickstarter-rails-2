class CartController < ApplicationController
  def show
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_cart_item = @cart.cart_items.find_by(product_id: @product.id)
    if current_cart_item && quantity > 0
      current_cart_item.update(quantity:)
    elsif quantity <= 0
      current_cart_item.destroy
    else
      @cart.cart_items.create(product: @product, quantity:)
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart}),
                              turbo_stream.replace(@product),
                             ]
      end
    end

    redirect_to product_path(@product), notice: 'Product added to cart successfully.'
  end

  def remove
    CartItem.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart})
      end
    end
  end
end
