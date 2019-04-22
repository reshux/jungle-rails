class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    stripped_email = params[:email].strip.downcase
    if user = User.authenticate_with_credentials(stripped_email, params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login', notice: "Wrong input"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
