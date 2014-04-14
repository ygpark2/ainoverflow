# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '73bfb754d5e12c7a471f1a671b31137d'

  # before_filter :require_user
  before_filter :load_default_flash_messages
  # after_filter :store_location

  before_action :authenticate_user!

  private

  def require_admin
    unless current_user && current_user.admin
      store_location
      flash[:notice] = t('flash.notice.application.require_admin.invalid')
      redirect_to new_user_session_url
      return false
    end
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = t('flash.notice.application.require_user.invalid')
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = t('flash.notice.application.require_no_user.invalid')
      redirect_to root_path
      return false
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def load_default_flash_messages
    [:notice , :error].each do |f|
      flash[f]=''
    end
  end

end
