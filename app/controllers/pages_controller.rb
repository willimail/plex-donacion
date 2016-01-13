class PagesController < ApplicationController
  #protect_from_forgery except: :welcome
  before_action :require_user, only: [:welcome, :index]
  
  def index
    @users = User.all
  end
  def welcome
  end
  
end
