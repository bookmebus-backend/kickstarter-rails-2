class ProductsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy, :edit]
    before_action :check_admin, only: [:new, :create, :update, :destroy, :edit]

    def index
        @products = Product.all
    end

    def show
        @product = Product.find(params[:id])
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to @product, notice: "Product was successfully created."
        else
            render :new
        end
    end

    def edit
        @product = Product.find(params[:id])
    end 
    
    def update
        @product = Product.find_by(id: params[:id])
        if @product.update(product_params)
            redirect_to products_path, notice: "Product was successfully updated."
        else
            render :edit
        end
    end

    def destroy
        @product = Product.find(params[:id])
        if @product
            @product.destroy
            flash[:notice] = 'Product deleted successfully.'
        else
            flash[:alert] = 'Product not found.'
        end
        redirect_to products_path
    end

    private

    def set_product
        @product = Product.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:name, :description, :price, :image)
    end

    def check_admin
        unless current_user&.admin?
            flash[:alert] = 'You do not have permission to access this page.'
            redirect_to root_path
        end
    end

end
