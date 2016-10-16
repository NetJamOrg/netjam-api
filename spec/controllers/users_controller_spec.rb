require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DeleteMesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all delete_mes as @delete_mes" do
      user = User.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:users)).to eq([user])
    end
  end

end
