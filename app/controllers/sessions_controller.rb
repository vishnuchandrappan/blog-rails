class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Login Successful ! Welcome back"
      log_in user
      redirect_to root_path
    else
      flash[:danger] = "Invalid Email - Password Combination"
      render 'new'
    end
  end

  def destroy
  end
end
