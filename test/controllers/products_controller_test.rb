class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]

  before_action :set_product, only: %i[show edit update destroy buy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy!
    redirect_to products_path, notice: "Product was successfully deleted."
  end

  def buy
    if @product.in_stock?
      @product.decrement_inventory!
      redirect_to @product, notice: "Product purchased successfully."
    else
      redirect_to @product, alert: "Product is out of stock."
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :inventory_count
    )
  end
end
