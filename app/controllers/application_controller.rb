class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:user_update) { |u| u.permit(:name, :avatar, :email, :password, :current_password)}
  end
end
