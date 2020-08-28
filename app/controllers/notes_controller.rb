class NotesController < ApplicationController
    before_action :find_product
    before_action :find_note, only: [:edit, :update, :destroy]

    def new
        @note = Note.new
    end

    def create
        @note = Note.new(note_params)
        @note.product_id = params[:product_id]
        @note.save
    end

    def destroy
      @note = Note.find(params[:id])
      @note.destroy
      redirect_to product_path(@product)
    end
    
    def edit 
      redirect_to root_path if current_user.id != @note.user_id 
    end
    
    def update
      if @note.update(note_params)
        redirect_to product_path(@product)
      else
        render 'edit'
      end
    end

    private

      def note_params
        params.require(:note).permit(:user_id, :product_id, :content)
      end

      def find_product
        @product = Product.find(params[:product_id])
      end

      def find_note
        @note = Note.find(params[:id])
      end    
end
