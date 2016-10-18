# This class facilitates oauth2 authentication. successful oauth callbacks redirect to #create,
# where the session is created with the information of the associated user in our db (which is created if necessary).

class SessionsController < ApplicationController

  def create
    @user = User.where(provider: auth_hash[:provider], oauth_uid: auth_hash[:uid]).first
    if @user&.id.nil? # create user if not exist
      @user = User.create(provider: auth_hash[:provider], oauth_uid: auth_hash[:uid], name: auth_hash[:info][:name], email: auth_hash[:info][:email], username: auth_hash[:info][:email])
    end
    if @user&.id != nil
      session[:current_user] = @user
      render json: @user
    else
      head :not_found
    end
  end


  def destroy
    session[:current_user] = @user = nil
  end

  protected def auth_hash
    request.env['omniauth.auth']
  end
end
