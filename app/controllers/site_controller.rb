class SiteController < ApplicationController
  before_filter :require_user, only: [ :dashboard ]

  def index
  end

  def dashboard
    @user = current_user
  end

end
