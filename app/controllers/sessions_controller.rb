# This class facilitates oauth2 authentication. successful oauth callbacks redirect to #create,
# where the session is created with the information of the associated user in our db (which is created if necessary).

require 'jwt'
require 'dalli'

class SessionsController < ApplicationController

  HMAC_SECRET = ENV['JWT_HMAC_SECRET']

  def create
    @user = User.where(provider: auth_hash[:provider], oauth_uid: auth_hash[:uid]).first
    if @user&.id.nil? # create user if not exist
      @user = User.create(provider: auth_hash[:provider], oauth_uid: auth_hash[:uid], name: auth_hash[:info][:name], email: auth_hash[:info][:email], username: auth_hash[:info][:email])
    end
    if @user&.id != nil
      byebug
      # create and return a json web token. disregard any session bullshit
      payload = { user: @user.as_json, exp: (DateTime.now + 5.minutes).to_i }
      token = JWT.encode payload, HMAC_SECRET, 'HS256'
      # delete session_id cookie leftover from oauth
      # cookies.delete
      byebug
      # return jwt
      render json: token
    else
      head :not_found
    end
  end


  def destroy
    # TODO: add token to a different memcache namespace with expires = tok.valid_until, data: {disabled: true}
    # and check this in app controller is valid etc
  end

  protected def auth_hash
    request.env['omniauth.auth']
  end
end
