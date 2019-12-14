require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Joao',
      document: '12345678910'
    }
  end
  let(:missing_attributes) { { invalid: 'teste' } }
  let(:invalid_attributes) do
    {
      name: 'Joao',
      document: nil
    }
  end

  describe 'GET #index' do
    it 'retorna todos clientes' do
      create_list(:client, 5)
      get :index
      expect(response).to be_successful
      expect(response.headers.keys).not_to include('Link')
      expect(response.headers['Total'].to_i).to eq(5)
      expect(response.headers['Per-Page'].to_i).to eq(25)
    end
  end

  describe 'GET #show' do
    context 'quando busca um registro existente' do
      let!(:client) { create(:client) }
      it 'retorna o cliente com sucesso' do
        get :show, params: { id: client.id }
        parsed_body = JSON.parse(response.body)
        expect(response).to be_successful
        expect(parsed_body['id']).to eq(client.id)
        expect(parsed_body['name']).to eq(client.name)
        expect(parsed_body['document']).to eq(client.document)
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
      it 'cria um novo cliente' do
        expect {
          post :create, params: { client: valid_attributes }
        }.to change(Client, :count).by(1)
      end

      it 'retorna um JSON com cliente criado' do
        post :create, params: { client: valid_attributes }
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
        post :create, params: { client: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:client) { create(:client) }

    context 'com parametros validos' do
      it 'atualiza o cliente informado' do
        put :update, params: { id: client.id, client: valid_attributes }
        created_client = Client.find(client.id)
        expect(created_client.name).to eq('Joao')
        expect(created_client.document).to eq('12345678910')
      end

      it 'retorna um JSON com os dados do cliente atualizados' do
        put :update, params: { id: client.id, client: valid_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'com parametros invalidos' do
      it 'retorna um JSON com os erros' do
        put :update, params: { id: client.id, client: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'sem parametros obrigatórios' do
      it 'retorna um JSON com os erros' do
        put :update, params: { id: client.id, client: {} }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
