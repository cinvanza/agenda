class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    contacts_path # Redirige al index de contactos
  end
end
