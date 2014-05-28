class UsersController < ApplicationController

  def signup
    if request.post?
      @user = User.create(user_params)
      if @user.valid?
        flash[:success] = "Account created successfully."
        session[:user_id] = @user.id
        redirect_to dashboard_path
      end
    else
      @user = User.new
    end
  end

  def login
    if @user = User.find_by_email(params[:user][:email])
      if @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to dashboard_path
      else
        flash[:error] = "Your password is incorrect."
        redirect_to home_path
      end
    else
      flash[:error] = "There is no user with that email."
      redirect_to home_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "You've been logged out."
    redirect_to home_path
  end

  def toggle_anonymity
    case params[:do]
    when 'enable'
      current_user.update_attribute(:anonymous, true)
      flash[:success] = "You identity is now protected."
    when 'disable'
      current_user.update_attribute(:anonymous, false)
      flash[:success] = "You are no longer anonymous."
    end

    redirect_to dashboard_path
  end

  def verify_phone

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone)
    end
end
