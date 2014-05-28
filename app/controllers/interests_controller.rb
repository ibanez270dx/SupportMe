class InterestsController < ApplicationController

  def add
    interest = Interest.find_or_create_by(name: params[:interest][:name])
    current_user.interests << interest
    current_user.save

    flash[:success] = "Added #{params[:name]} as an interest."
    redirect_to dashboard_path
  end

  def list
    render json: Interest.where("name like ?", "#{params[:term]}%").collect(&:name)
  end

end
