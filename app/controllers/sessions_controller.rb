class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) 
      session[:user_id] = user.id
      redirect_to '/'
    else
      @user = User.new
      flash.now[:alert] = 'Wrong Credentials!'
      render(:'sessions/new')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
