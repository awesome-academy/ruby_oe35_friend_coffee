class ApplicationController < ActionController::Base
<<<<<<< HEAD
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
=======
>>>>>>> 3e3cce0 (Init project)
end
