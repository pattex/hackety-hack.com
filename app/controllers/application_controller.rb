class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :title

  def title t=nil
    @title = t unless t.blank?
    @title
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_url, :alert => exception.message
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  before_filter :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
