# This class facilitates oauth2 authentication. successful oauth callbacks redirect to #create,
# where the jwt token is created with the information of the associated user in our db (which is created if necessary).

class SessionsController < ApplicationController

  before_action :ensure_user_authorized, except: [:create, :auth_hash]

  def create
    @user = User.where(provider: auth_hash[:provider], oauth_uid: auth_hash[:uid]).first
    if @user&.id.nil? # create user if not exist
      @user = User.create(provider: auth_hash[:provider], oauth_uid: auth_hash[:uid], name: auth_hash[:info][:name], email: auth_hash[:info][:email], username: auth_hash[:info][:email])
    end
    if @user&.id != nil
      # create and return a json web token.
      payload = { user: @user.as_json, exp: (DateTime.now + 5.minutes).to_i, iat: Time.now.to_i }
      token = JWT.encode payload, Rails.application.config.JWT_HMAC_SECRET, 'HS256'
      render json: token
    else
      head :not_found
    end
  end


  def destroy
    begin
      Rails.application.config.logout_memcached_client.set(raw_jwt_token_str, true)
      Rails.application.config.logout_memcached_client.touch(raw_jwt_token_str, decoded_token[:payload][:exp])
    rescue JWT::DecodeError
      head :unauthorized
    end
  end

  protected def auth_hash
    request.env['omniauth.auth']
  end
end
