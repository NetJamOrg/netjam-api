class ApplicationController < ActionController::API

  def current_user
    session[:current_user]
  end

  def user_authorized?
    current_user&.id != nil
  end

  def ensure_user_authorized
    if !user_authorized?
      redirect_to '/login'
    end
  end
end
