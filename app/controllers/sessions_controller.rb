class SessionsController < ApplicationController

  def create
    @tweeter = Tweeter.where("screen_name ilike ?", auth_hash[:info][:nickname]).first
    @tweeter ||= Tweeter.create(screen_name: auth_hash[:info][:nickname])
    @tweeter.update_with_auth_hash(auth_hash)
    session[:user_id] = @tweeter.id
    if @tweeter.privileges.present?
      redirect_to dashboard_path(screen_name: @tweeter.screen_name)
    else
      redirect_to tweeter_grants_path(@tweeter)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end

end
