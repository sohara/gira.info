# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  before_filter :set_locale
  
  def set_locale
    I18n.backend.available_locales
    I18n.locale = extract_locale_from_uri
  end

  def extract_locale_from_uri
    parsed_locale = request.path.split('/')[1]
    logger.info "request path is #{request.path}"
    logger.info "!!!!!!!!!!!!!!! locale is #{parsed_locale}"
    (I18n.backend.available_locales.include? parsed_locale) ? parsed_locale  : nil
  end
 
end
