require 'rails_helper'


RSpec.describe "Auth", type: :request do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "Authorization" do
    it "gets auth" do
      get '/auth/google_oauth2/callback'
      byebug
      expect(response).to have_http_status(200)
    end
  end
end
