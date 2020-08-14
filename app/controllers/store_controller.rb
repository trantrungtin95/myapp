class StoreController < ApplicationController
  skip_before_action :authorize
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
  end
end
