class ApplicationController < ActionController::API
  # disable csrf
  skip_before_action :verify_authenticity_token

  def current_user
    session[:current_user]
  end

  def user_authorized?
    current_user&.id != nil
  end

  def ensure_user_authorized
    if !user_authorized?
      head :unauthorized
    end
  end
end
