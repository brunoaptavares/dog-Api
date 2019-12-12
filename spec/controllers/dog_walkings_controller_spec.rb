require 'rails_helper'

RSpec.describe DogWalkingsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # DogWalking. As you add validations to DogWalking, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DogWalkingsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      dog_walking = DogWalking.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      dog_walking = DogWalking.create! valid_attributes
      get :show, params: {id: dog_walking.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new DogWalking" do
        expect {
          post :create, params: {dog_walking: valid_attributes}, session: valid_session
        }.to change(DogWalking, :count).by(1)
      end

      it "renders a JSON response with the new dog_walking" do

        post :create, params: {dog_walking: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(dog_walking_url(DogWalking.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new dog_walking" do

        post :create, params: {dog_walking: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested dog_walking" do
        dog_walking = DogWalking.create! valid_attributes
        put :update, params: {id: dog_walking.to_param, dog_walking: new_attributes}, session: valid_session
        dog_walking.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the dog_walking" do
        dog_walking = DogWalking.create! valid_attributes

        put :update, params: {id: dog_walking.to_param, dog_walking: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the dog_walking" do
        dog_walking = DogWalking.create! valid_attributes

        put :update, params: {id: dog_walking.to_param, dog_walking: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested dog_walking" do
      dog_walking = DogWalking.create! valid_attributes
      expect {
        delete :destroy, params: {id: dog_walking.to_param}, session: valid_session
      }.to change(DogWalking, :count).by(-1)
    end
  end

end
