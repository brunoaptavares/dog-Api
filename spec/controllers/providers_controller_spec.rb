require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
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
    it 'retorna todos prestadores' do
      create_list(:provider, 5)
      get :index
      expect(response).to be_successful
      expect(response.headers.keys).not_to include('Link')
      expect(response.headers['Total'].to_i).to eq(5)
      expect(response.headers['Per-Page'].to_i).to eq(25)
    end
  end

  describe 'GET #show' do
    context 'quando busca um registro existente' do
      let!(:provider) { create(:provider) }
      it 'retorna o prestador com sucesso' do
        get :show, params: { id: provider.id }
        parsed_body = JSON.parse(response.body)
        expect(response).to be_successful
        expect(parsed_body['id']).to eq(provider.id)
        expect(parsed_body['name']).to eq(provider.name)
        expect(parsed_body['document']).to eq(provider.document)
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
      it 'cria um novo prestador' do
        expect {
          post :create, params: { provider: valid_attributes }
        }.to change(Provider, :count).by(1)
      end

      it 'retorna um JSON com o prestador criado' do
        post :create, params: { provider: valid_attributes }
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
        post :create, params: { provider: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:provider) { create(:provider) }

    context 'com parametros validos' do
      it 'atualiza o provedor informado' do
        put :update, params: { id: provider.id, provider: valid_attributes }
        created_provider = Provider.find(provider.id)
        expect(created_provider.name).to eq('Joao')
        expect(created_provider.document).to eq('12345678910')
      end

      it 'retorna um JSON com os dados do prestador atualizados' do
        put :update, params: { id: provider.id, provider: valid_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'com parametros invalidos' do
      it 'retorna um JSON com os erros' do
        put :update, params: { id: provider.id, provider: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'sem parametros obrigatórios' do
      it 'retorna um JSON com os erros' do
        put :update, params: { id: provider.id, provider: {} }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
