class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  respond_to :json, :datatable

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :email]
      devise_parameter_sanitizer.for(:sign_in) << [:email]
    end

  protect_from_forgery with: :exception
end



