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

  def send_verification
    token = Digest::SHA1.hexdigest([Time.now, rand].join)
    current_user.token = token
    current_user.save
    NEXMO.send_message!(
      to: current_user.phone,
      from: '12134657508',
      text: "Click the link to verify your phone number with Support.Me http://humani.se:3000/verify/#{token}/ ... DO IT " )
  end

  def receive_verification
    user = User.find_by_token(params[:token])
    if user
      user.verified = true
      user.save
    end

    render text: 'Your phone is now verified!'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone)
    end
end
