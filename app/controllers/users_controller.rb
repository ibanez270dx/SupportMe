class UsersController < ApplicationController

  def create
    @user = Admin.create(admin_params)
    if @user.valid?
      flash[:success] = "Account created successfully."
      redirect_to dashboard_path
    else
      render action: 'new'
    end
  end

end
