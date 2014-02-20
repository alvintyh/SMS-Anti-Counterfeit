# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_dashboard_path, :alert => exception.message
  end


  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    
  end
  #helper_method :current_user
  def set_admin_locale
    I18n.locale = :vi
  end
  
  #def authenticate_admin_user! 
  #  render_403 and return if admin_login? && current_ability
    #authenticate_user! 
  #end


end