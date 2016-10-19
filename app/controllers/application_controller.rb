class ApplicationController < ActionController::API

  HMAC_SECRET = ENV['JWT_HMAC_SECRET']

  def current_user_hash
    byebug
    token = request.headers['Authorization'].sub(/^Bearer /, '') # remove leading 'Bearer'
    begin
      decoded_token = JWT.decode token, HMAC_SECRET, true, { algorithm: 'HS256' }
    rescue JWT::ExpiredSignature
      render json: { error: 'Session has expired' }, status: 403
    rescue JWT::DecodeError => e
      # https://github.com/jwt/ruby-jwt/blob/master/lib/jwt/error.rb
      head :unauthorized
      return nil
    end
    byebug
    # Array
    # [
    #   {"data"=>"test"}, # payload
    #   {"typ"=>"JWT", "alg"=>"none"} # header
    # ]
    # TODO check against logged_out db
    payload = decoded_token[0]
    return payload['user']
  end

  def user_authorized?
    byebug
    token = request.headers['Authorization'].sub(/^Bearer /, '') # remove leading 'Bearer'
    begin
      # just check decode successful
      JWT.decode token, HMAC_SECRET, true, { algorithm: 'HS256' }
    rescue JWT::DecodeError => e
      # https://github.com/jwt/ruby-jwt/blob/master/lib/jwt/error.rb
      head :unauthorized
      return false
    end
    return true
  end

  def ensure_user_authorized
    if !user_authorized?
      head :unauthorized
    end
  end
end
