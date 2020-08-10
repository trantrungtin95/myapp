class CommentsController < ApplicationController
    before_action :find_review
    before_action :find_comment, only: [ :edit, :update, :destroy ]

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(review_params)
        @product.review_id = params[:review_id]

        if @comment.save
            redirect_to product_path(@product)
        else
            render 'new'
        end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to product_path(@product)
    end
    
    def edit  
    end
    
    def update
      if @comment.update(comment_params)
        redirect_to product_path(@product)
      else
        render 'edit'
      end
    end

    private

      def comment_params
        params.require(:comment).permit( :user_id, :review_id)
      end

      def find_review
        @review = Review.find(params[:review_id])
      end

      def find_comment
        @comment = Comment.find(params[:id])
        end

end