class ReviewsController < ApplicationController
    before_action :find_product
    before_action :find_review, only: [:edit, :update, :destroy, :like, :dislike, :comment]
    
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

    def like
      # get like from db
      # if user already like, do nothing. Otherwise, increase 1
      # save like to db

      if @review.like_by?(current_user)
        # do nothing
      else
        @review.likes.create(user_id: current_user.id)
      end
      redirect_to product_path(@product)
    end

    def dislike
      if @review.like_by?(current_user)
        @review.likes.where(user_id: current_user.id).destroy_all
      end
      redirect_to product_path(@product)
    end
    


    private

      def review_params
        params.require(:review).permit(:rating, :comment, :user_id, :like)
      end

      def find_product
        @product = Product.find(params[:product_id])
      end

      def find_review
        @review = Review.find(params[:id])
      end    
    
end
