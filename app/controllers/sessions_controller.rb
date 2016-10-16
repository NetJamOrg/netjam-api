class SessionsController < ApplicationController
  def create
    byebug
    @user = User.where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first_or_create
    self.current_user = @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
