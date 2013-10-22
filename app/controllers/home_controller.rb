class HomeController < ApplicationController

  def index
    redirect_to "/" + current_user.screen_name if current_user
  end

end
