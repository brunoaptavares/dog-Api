require 'rails_helper'

RSpec.describe PetsController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Joao',
      breed: 'vira lata',
      client_id: client.id
    }
  end
  let(:missing_attributes) { { invalid: 'teste' } }
  let(:invalid_attributes) do
    {
      name: 'Joao',
      breed: nil,
      client_id: client.id
    }
  end
  let!(:client) { create(:client) }

  describe 'GET #index' do
    it 'retorna todos pets' do
      create_list(:pet, 5)
      get :index
      expect(response).to be_successful
      expect(response.headers.keys).not_to include('Link')
      expect(response.headers['Total'].to_i).to eq(5)
      expect(response.headers['Per-Page'].to_i).to eq(25)
    end
  end

  describe 'GET #show' do
    context 'quando busca um registro existente' do
      let!(:pet) { create(:pet) }
      it 'retorna o pet com sucesso' do
        get :show, params: { id: pet.id }
        parsed_body = JSON.parse(response.body)
        expect(response).to be_successful
        expect(parsed_body['id']).to eq(pet.id)
        expect(parsed_body['name']).to eq(pet.name)
        expect(parsed_body['breed']).to eq(pet.breed)
        expect(parsed_body['client_id']).to eq(pet.client_id)
      end
    end

    context 'quando busca um registro inexistente' do
      it 'retorna json de erro' do
        get :show, params: { id: 'x' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'com parametros obrigatórios' do
      it 'cria um novo pet' do
        expect {
          post :create, params: { pet: valid_attributes }
        }.to change(Pet, :count).by(1)
      end

      it 'retorna um JSON com pet criado' do
        post :create, params: { pet: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'sem parametros obrigatórios' do
      it 'retorna um JSON com os erros' do
        post :create, params: {}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'com parametros invalidos' do
      it 'retorna um JSON com os erros' do
        post :create, params: { pet: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:pet) { create(:pet) }

    context 'com parametros validos' do
      it 'atualiza o pet informado' do
        put :update, params: { id: pet.id, pet: valid_attributes }
        created_pet = Pet.find(pet.id)
        expect(created_pet.name).to eq('Joao')
        expect(created_pet.breed).to eq('vira lata')
        expect(created_pet.client_id).to eq(client.id)
      end

      it 'retorna um JSON com os dados do pet atualizados' do
        put :update, params: { id: pet.id, pet: valid_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'com parametros invalidos' do
      it 'retorna um JSON com os erros' do
        put :update, params: { id: pet.id, pet: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'sem parametros obrigatórios' do
      it 'retorna um JSON com os erros' do
        put :update, params: { id: pet.id, pet: {} }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
