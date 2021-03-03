class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token, only: [:create]
  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      @current_user = user
    else
      redirect_to login_url, :alert => "Invalid username/password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_path, :notice => "Logged out"
  end
end
