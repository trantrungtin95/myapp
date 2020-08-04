class ReviewsController < ApplicationController
    before_action :find_product
    before_action :find_review, only: [:edit, :update, :destroy]
    def new
        @review = Review.new
    end

    def create
        @review = Review.new(review_params)
        @review.product_id = params[:product_id]

        if @review.save
            redirect_to product_path(@product)
        else
            render 'new'
        end
    end

    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      redirect_to product_path(@product)
    end
    
    def edit  
    end
    
    def update
      if @review.update(review_params)
        redirect_to product_path(@product)
      else
        render 'edit'
      end
    end

    private

      def review_params
        params.require(:review).permit(:rating, :comment)
      end

      def find_product
        @product = Product.find(params[:product_id])
      end

      def find_review
        @review = Review.find(params[:id])
      end
    
end
