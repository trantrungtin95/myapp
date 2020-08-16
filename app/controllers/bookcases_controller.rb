class BookcasesController < ApplicationController
    before_action :set_bookcase, only: [:show, :edit, :update, :destroy]



    def index
        puts "======================================"
        @bookcases = Bookcase.paginate(:page => params[:page], :per_page => 10).order('created_at desc')
    end

    def show
    end

    def new 
        @bookcase = Bookcase.new
    end

    def edit 
    end  

    def create 
        @bookcase = Bookcase.new(bookcase_params)

        respond_to do |format|
          if @bookcase.save
            format.html { redirect_to user_bookcase_path(@bookcase.user, @bookcase), notice: 'Bookcase was successfully created.' }
            format.json { render :show, status: :created, location: @bookcase }
          else
            format.html { render :new }
            format.json { render json: @bookcase.errors, status: :unprocessable_entity }
          end
        end
    end

    def update 
        respond_to do |format|
            if @bookcase.update(bookcase_params)
              
              # FIXME: path is not correct
              format.html { redirect_to user_bookcase_path(@bookcase.user, @bookcase), notice: 'Bookcase was successfully updated.' }
              format.json { render :show, status: :ok, location: @bookcase }
            else
              format.html { render :edit }
              format.json { render json: @bookcase.errors, status: :unprocessable_entity }
            end
          end
    end

    def destroy 
        @bookcase.destroy
        # FIXME: path is not correct
        respond_to do |format|
          format.html { redirect_to user_bookcases_path(@bookcase.user.id), notice: 'Bookcase was successfully destroyed.' }
          format.json { head :no_content }
    end
    end

  private

    def set_bookcase
      @bookcase = Bookcase.find(params[:id])
    end

    def bookcase_params
      params.require(:bookcase).permit(:user_id, :title, :description, :image_url)
    end
  
end
