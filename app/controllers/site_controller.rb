class SiteController < ApplicationController
  before_filter :require_user, only: [ :dashboard ]

  def index
  end

  def dashboard
    @user = current_user
  end

  def support

  end

  def connect
    interest = Interest.find(params[:interest])
    if interest
      user = interest.users.first
      NEXMO.send_message!(to: user.phone, from: '12134657508', "Initialized chat with #{current_user.name}")
    end
  end

  def callback
    render text: 'callback!'
  end

end
