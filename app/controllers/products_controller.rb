class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :verify_owner, only: [:edit, :update, :destroy]

  # GET /products or /products.json
  def index


    @all_categories = Category.all
    categories = []
    if params.has_key?(:categories)
      categories = Category.where(id: params[:categories]).pluck(:id).to_a
    end
    q = Product.joins(:categories)

    if categories.length > 0
      q = q.where('categories.id in (?)', categories)
    end
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @categories = Category.all
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    temp_params = product_params
    temp_params.delete(:categories)
    temp_params.delete(:new_categories)
    @product = Product.new(temp_params)
    @product.categories = associate_categories
    @product.user = current_user

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        @categories = Category.all
        format.html { render :new } # only render new.html.erb
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      not_found
    end

    def verify_owner
      flash[:notice] = "Not allowed"
      return redirect_to products_path if current_user != @product.user
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :stock, :price, :new_categories, :categories => []) ## hash
    end
    def associate_categories
      existing_categories = Category.where(id: product_params[:categories]).to_a
      # create new cats from names string
      new_cats_string_array = product_params[:new_categories].split(',')
      new_cats_hash_array = new_cats_string_array.map { |cat| {name: cat} }
      new_categories = Category.create(new_cats_hash_array)
      # remove records with id: nil
      new_categories.each do  |cat|
        if cat.id == nil
          new_categories.delete(cat)
        end
      end
      existing_categories + new_categories
    end
end
