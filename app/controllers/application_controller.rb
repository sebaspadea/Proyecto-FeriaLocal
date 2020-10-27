class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
