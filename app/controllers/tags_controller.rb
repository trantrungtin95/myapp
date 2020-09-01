class TagsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
    end
    
    def show
    end

    def new
        @tag = Tag.new
    end

    def edit
    end

    def create
        @tag = Tag.new(tag_params)

        respond_to do |format|
            if @tag.save
              format.html { redirect_to products_path, notice: 'Tag was successfully created.' }
            else
              format.html { render :new }
            end
          end
    end 

    private

      def set__tag
        @tag = Tag.find(params[:id])
      end

      def tag_params
        params.require(:tag).permit(:attribute_name)
      end

end
