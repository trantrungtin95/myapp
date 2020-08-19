class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :luotxem, :favorite, :disfavorite]

  # GET /products
  # GET /products.json
  def index
    puts "======================================"
    @products = Product.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
    if params['q'].present?
      @products = Product.find_title(params['q']).paginate(:page => params[:page], :per_page => 10).order('created_at desc')
    end
  end

  # GET /products/1
  # GET /products/1.json
  # Avoid spam: captcha. Prove that you're human
  def show
    # @product.luotxem.create(user_id: current_user.id)
    # Migrate old data. Script: copy luottxem ---> daxem
    
    new_views = (@product.daxem.present? ? @product.daxem : 0) + 1
    @product.update(daxem: new_views)
    ###
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def favorite
    if @product.favorite_by?(current_user)
      # do nothing
    else
      @product.favorites.create(user_id: current_user.id)
    end
    redirect_to product_path(@product)
    end

    def disfavorite
      if @product.favorite_by?(current_user)
        @product.favorites.where(user_id: current_user.id).destroy_all
      end
      redirect_to product_path(@product)
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :cover)
    end
  
end  
