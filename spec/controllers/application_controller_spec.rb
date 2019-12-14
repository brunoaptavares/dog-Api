require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def index
      raise ActiveRecord::RecordInvalid if params[:id] == '1'

      raise ActiveRecord::RecordNotFound if params[:id] == '2'

      raise ActionController::ParameterMissing, 'teste'
    end
  end

  describe '#render_unprocessable_entity_response' do
    it 'retorna JSON de unprocessable_entity' do
      get :index, params: { id: 1 }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe '#render_not_found_response' do
    it 'retorna JSON de not_found_response' do
      get :index, params: { id: 2 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe '#render_bad_request' do
    it 'retorna JSON de bad_request' do
      get :index
      expect(response).to have_http_status(:bad_request)
    end
  end
end
