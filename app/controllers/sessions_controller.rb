class SessionsController < ApplicationController
  def create
    byebug
    @user = User.where(provider: auth_hash[:provider], oauth_uid: auth_hash[:uid]).first
    if @user&.id.nil? # create user if not exist
      @user = User.create(provider: auth_hash[:provider], oauth_uid: auth_hash[:uid], name: auth_hash[:info][:name], email: auth_hash[:info][:email], username: auth_hash[:info][:email])
    end
    if @user.persised?
      session[:current_user] = @user
      render json: @user
    else
      respond_with_error 'failed to log you in', 404
    end
  end


  def destroy
    session[:current_user] = @user = nil
  end

  protected def auth_hash
    request.env['omniauth.auth']
  end
end
