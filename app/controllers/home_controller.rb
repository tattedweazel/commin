class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'application'
  def index
    @posts = current_user.all_posts.eager_load(:user, :sent_to_user)
  end
end
