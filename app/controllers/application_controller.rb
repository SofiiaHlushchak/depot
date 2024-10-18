# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
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

  def set_i18n_locale_from_params
    return unless params[:locale]

    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
    else
      flash.now[:notice] =
        "#{params[:locale]} translation not available"
      logger.error flash.now[:notice]
    end
  end
end
