class ApplicationController < ActionController::API

  HMAC_SECRET = ENV['JWT_HMAC_SECRET']

  # TODO implement more specific error handling
  # https://github.com/jwt/ruby-jwt/blob/master/lib/jwt/error.rb

  # [ {"data"=>"test"}, # payload
  #   {"typ"=>"JWT", "alg"=>"whatever"} # header ]

  def raw_jwt_token_str
    # remove leading 'Bearer'
    request.headers['Authorization']&.sub(/^Bearer /, '')
  end

  def decoded_token
    decoded_tok = JWT.decode raw_jwt_token_str, HMAC_SECRET, true, { algorithm: 'HS256' }
    return { payload: decoded_tok[0], header: decoded_tok[1] }.deep_symbolize_keys!
  end

  def current_user_hash
    begin
      return decoded_token[:payload][:user]
    rescue JWT::ExpiredSignature
      render json: { error: 'Session has expired' }, status: 403
    rescue JWT::DecodeError
      head :unauthorized
      return nil
    end
  end

  def user_authorized?
    begin
      # just check token exists, decode successful, and user not logged out
      !raw_jwt_token_str.nil? and !decoded_token.nil? and !Rails.application.config.logout_memcached_client.get(raw_jwt_token_str)
    rescue JWT::ExpiredSignature
      render json: { error: 'Session has expired' }, status: 403
      false
    rescue JWT::DecodeError
      # https://github.com/jwt/ruby-jwt/blob/master/lib/jwt/error.rb
      head :unauthorized
      false
    end
  end

  def ensure_user_authorized
    if !user_authorized?
      head :unauthorized
    end
  end
end
