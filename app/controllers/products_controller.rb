class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:last_page, :bookmark]
  before_action :set_product, only: [:show, :edit, :update, :destroy, :luotxem, :favorite, :disfavorite, :private, :public]
 
  # GET /products
  # GET /products.json
  def index
    puts "======================================"
    @products = Product.where(public: true).order('created_at desc').paginate(:page => params[:page], :per_page => 10)
    if params['q'].present?
      @products = Product.find_title(params['q']).order('created_at desc').paginate(:page => params[:page], :per_page => 10)
    end
  end

  # GET /products/1
  # GET /products/1.json
  # Avoid spam: captcha. Prove that you're human
  def show
    # @product.luotxem.create(user_id: current_user.id)
    # Migrate old data. Script: copy luottxem ---> daxem
    
    new_views = (@product.daxem.present? ? @product.daxem : 0) + 1
    new_day_views = (@product.day_views.present? ? @product.day_views : 0) + 1
    new_week_views = (@product.week_views.present? ? @product.week_views : 0) + 1
    new_month_views = (@product.month_views.present? ? @product.month_views : 0) + 1
    @product.update(daxem: new_views, day_views: new_day_views, week_views: new_week_views, month_views: new_month_views)
    # calculate most view in day (yesterday)
    # solution: memory, speed
    # approach 1: create record for each view: ==> cost memory in db
    # approach 2: create column da_xem_trong_ngay. 
    #   - tang 1 khi co view. 
    #   - Het ngay, reset ve 0. Schedule job / Cron job: whenever gem
    #   - save the results of most view a day. Top 10 products have most views
    # 
    if (current_user.id == @product.user_id) || @product.public
      if visited = Visited.where(user_id: current_user.id, product_id: @product.id).first
        visited.update(updated_at: Time.now)
      else
        Visited.create(user_id: current_user.id, product_id: @product.id)
      end

    else
      redirect_to root_path
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    redirect_to root_path if current_user.id != @product.user_id
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

  def private
    @product.update(public: false)
    Newbook.where(product_id: @product.id).destroy_all
    redirect_to product_path(@product)
  end

  def public
    @product.update(public: true)
    Newbook.create(product_id: @product.id)
    redirect_to product_path(@product)
  end

  def most_views
    @most_day_views_products = MostView.where(kind: :day).order('postion asc').map(&:product)
    @most_week_views_products = MostView.where(kind: :week).order('postion asc').map(&:product)
    @most_month_views_products = MostView.where(kind: :month).order('postion asc').map(&:product)
    # [Mostview(product_id=5] --map--> [Product(id: 5)]
  end

  def last_page
    # TODO: create last page
    if last_page = LastPage.where(user_id: current_user.id, product_id: params[:id]).first
      last_page.update(page_number: params[:last_page])
    else
    last_page = LastPage.create(user_id: current_user.id, product_id: params[:id], page_number: params[:last_page])
    render json: { }, status: :ok
    end
  end

  def bookmark
    if bookmart = Bookmark.where(user_id: current_user.id, product_id: params[:id], page_number: params[:page_number]).first
    else
      bookmark = Bookmark.create(user_id: current_user.id, product_id: params[:id], page_number: params[:page_number])
      render json: {}, status: :ok
    end
  end

  # keywords
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :cover, :user_id, :pdf, :audio, :classify, 
        tag_ids: [])
    end
  
end  
