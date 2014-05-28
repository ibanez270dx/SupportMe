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
      sponsee = interest.users.first
      sponsee.connected_to = current_user.phone
      sponsee.save

      current_user.connected_to = sponsee.phone
      current_user.save

      sponsee_name = sponsee.anonymous? ? "anonymous" : sponsee.name
      current_user_name = current_user.anonymous? ? "anonymous" : current_user.name

      NEXMO.send_message!(to: sponsee.phone, from: '12134657508', text: "Initialized chat with #{current_user_name} for support with #{interest.name}")
      NEXMO.send_message!(to: current_user.phone, from: '12134657508', text: "Initialized chat with #{sponsee_name} for support with #{interest.name}")
    end
  end

  def callback
    sender = User.find_by_phone(params["msisdn"])
    recipient = User.find_by_phone(sender.connected_to)
    NEXMO.send_message!(to: recipient.phone, from: '12134657508', text: params['text'])
  end
end
