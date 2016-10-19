require 'rails_helper'


RSpec.describe "Auth", type: :request do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "Authorization" do
    let(:resp_body) { JSON.parse(response.body)}
    context 'can get token' do
      it "gets auth" do
        get '/auth/google_oauth2/callback'
        expect(response).to have_http_status(200)
      end
    end

    context 'using token on projects controller' do
      before(:each) {
        get '/auth/google_oauth2/callback'
        @tok = response.body
      }
      it 'fails with no token' do
        get '/api/projects'
        expect(response).to have_http_status(401)
      end

      it 'succeeds with good token' do
        get '/api/projects', headers: {Authorization: @tok}
        expect(response).to have_http_status(200)
      end

      it 'can logout' do
        get '/api/logout', headers: {Authorization: @tok}
        expect(response).to have_http_status(204)
        get '/api/projects', headers: {Authorization: @tok}
        expect(response).to have_http_status(401)
      end
    end
  end
end
