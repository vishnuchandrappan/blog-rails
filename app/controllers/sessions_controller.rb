class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = "Login Successful ! Welcome back"
      log_in user
      remember user
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid Email - Password Combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Log out successful"
    redirect_to root_url
  end

end
