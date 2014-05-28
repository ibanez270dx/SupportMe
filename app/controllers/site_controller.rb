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
    interest = Interest.find_by_name(params[:interest])
    if interest
      user = interest.users.first

      user.connected_to = current_user.phone
      user.save

      current_user.connected_to = user.phone
      current_user.save

      NEXMO.send_message!(to: user.phone, from: '12134657508', text: "Initialized chat with #{current_user.name}")
      NEXMO.send_message!(to: current_user.phone, from: '12134657508', text: "Initialized chat with #{user.name}")
    end
  end

  def callback
    sender = User.find_by_phone(params["msisdn"])
    recipient = User.find_by_phone(sender.connected_to)
    NEXMO.send_message!(to: recipient.phone, from: '12134657508', text: params['text'])
  end
end
