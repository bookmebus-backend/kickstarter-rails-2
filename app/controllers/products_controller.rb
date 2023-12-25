class ProductsController < ApplicationController
    before_action :authenticate_user!
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

    end 
    
    def update
        if @product.update(product_params)
            redirect_to @product, notice: "Product was successfully updated."
        else
            render :edit
        end
    end

    def destroy
        @product.destroy
        redirect_to @product, notice: "Product was successfully deleted."
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
