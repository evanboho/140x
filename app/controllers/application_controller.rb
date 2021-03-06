class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    begin
      @user ||= Tweeter.find(session[:user_id])
    rescue
      session[:user_id] = nil
    end
  end
end
