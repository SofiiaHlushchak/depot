# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorize
  allow_browser versions: :modern

  protected
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authorize
    return if current_user

    redirect_to login_url, notice: "Please log in"
  end
end
