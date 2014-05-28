class SiteController < ApplicationController

  def index
  end

  def login
  end

  def signup
    @user = User.new
  end

  def dashboard
  end

end
