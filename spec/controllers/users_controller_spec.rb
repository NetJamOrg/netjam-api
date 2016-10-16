require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_session) {
    {} # this controller doesn't need any session stuff yet
  }


  let(:rbody) { JSON.parse(response.body) }

  describe "GET #index" do
    it "returns all users" do
      users = create_list(:user, 5)
      # stub the model method
      allow(User).to receive(:all).and_return(users)
      get :index, params: {}, session: valid_session
      expect(response).to be_success
      # ensure all models are returned
      expect(rbody.length).to equal(5)
      # ensure all keys are preserved
      rbody.each do |h|
        expect(h.keys).to match_array(users[0].as_json.keys)
      end

    end
  end

end
