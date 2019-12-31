class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        flash[:success] = "Login Successful ! Welcome back"
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        flash[:danger] = "Account not activated, check mail for activation link"
        redirect_to root_url
      end
    else
      flash[:danger] = "Invalid Email - Password Combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Log out successful"
    redirect_to root_url
  end

end
