class ProductTagsController < ApplicationController
  skip_before_action :verify_authenticity_token

      def index
      end
    
      # GET /line_items/1
      # GET /line_items/1.json
      def show
      end
    
      # GET /line_items/new
      def new
        @product_tag = ProductTag.new
      end
    
      # GET /line_items/1/edit
      def edit
      end

      def create
        @product_tag = ProductTag.new(product_tag_params)
      end


      private

      def set_product_tag
        @product_tag = ProductTag.find(params[:id])
      end

      def product_tag_params
        params.require(:product_tag).permit(:product_id, :tag_id)
      end

end
