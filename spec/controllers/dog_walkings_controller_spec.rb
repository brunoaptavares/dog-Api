require 'rails_helper'

RSpec.describe DogWalkingsController, type: :controller do
  describe 'GET #index' do
    let!(:dgw) { create(:dog_walking, schedule_date: Time.zone.yesterday) }
    let!(:dgw_2) { create(:dog_walking, schedule_date: 2.days.from_now) }
    let!(:dgw_3) { create(:dog_walking, schedule_date: Time.zone.tomorrow) }

    context 'quando filtro e TODOS' do
      context 'sem paginacao' do
        it 'retorna todas caminhadas' do
          get :index
          expect(response.headers.keys).not_to include('Link')
          expect(response.headers['Total'].to_i).to eq(3)
          expect(response.headers['Per-Page'].to_i).to eq(25)
        end
      end

      context 'com paginacao' do
        it 'retorna primeira pagina de caminhadas' do
          create_list(:dog_walking, 50)
          get :index
          expect(response.headers.keys).to include('Link')
          expect(response.headers['Total'].to_i).to eq(53)
          expect(response.headers['Per-Page'].to_i).to eq(25)
        end
      end
    end

    context 'quando filtro e PROXIMOS' do
      it 'retorna apenas as proximas caminhadas' do
        get :index, params: { filter: '1' }
        expect(response.headers.keys).not_to include('Link')
        expect(response.headers['Total'].to_i).to eq(2)
        expect(response.headers['Per-Page'].to_i).to eq(25)
      end
    end
  end

  describe 'GET #show' do
    context 'quando busca um registro existente' do
      let!(:dgw) { create(:dog_walking, schedule_date: Time.zone.yesterday) }
      it 'retorna a caminhada com sucesso' do
        get :show, params: { id: dgw.id }
        parsed_body = JSON.parse(response.body)
        expect(response).to be_successful
        expect(parsed_body['id']).to eq(dgw.id)
        expect(parsed_body['status']).to eq(dgw.status)
        expect(parsed_body['price']).to eq(dgw.price.to_s)
        expect(parsed_body['duration']).to eq(dgw.duration)
        expect(parsed_body['latitude']).to eq(dgw.latitude)
        expect(parsed_body['longitude']).to eq(dgw.longitude)
        expect(parsed_body['provider_id']).to eq(dgw.provider_id)
        expect(parsed_body['actual_duration']).to eq(60)
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
    let!(:provider) { create(:provider) }
    let!(:pet1) { create(:pet) }
    let!(:pet2) { create(:pet) }
    let(:valid_attributes) do
      {
        schedule_date: '2019-12-20 12:12:12',
        duration: 60,
        latitude: '111111',
        longitude: '000000',
        provider_id: provider.id,
        pets:
          [{ id: pet1.id }, { id: pet2.id }]
      }
    end
    let(:missing_attributes) { { invalid: 'teste' } }
    let(:invalid_attributes) do
      {
        schedule_date: '2019-12-20 12:12:12',
        duration: 60,
        latitude: '111111',
        longitude: '000000',
        provider_id: 'x',
        pets:
          [{ id: pet1.id }, { id: pet2.id }]
      }
    end

    context 'com parametros obrigatórios' do
      it 'cria uma nova caminhada' do
        expect {
          post :create, params: { dog_walking: valid_attributes }
        }.to change(DogWalking, :count).by(1)
        expect(DogWalking.first.pets.count).to be(2)
      end

      it 'retorna um JSON com a caminhada criada' do
        post :create, params: { dog_walking: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'sem parametros obrigatórios' do
      it 'retorna um JSON com os erros' do
        post :create, params: { dog_walking: missing_attributes }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'com parametros invalidos' do
      it 'retorna um JSON com os erros' do
        post :create, params: { dog_walking: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #start_walk' do
    context 'quando inicia uma caminhada agendada' do
      let!(:dgw) { create(:dog_walking) }
      it 'retorna sucesso' do
        post :start_walk, params: { id: dgw.id }
        expect(response).to be_successful
      end
    end

    context 'quando inicia uma caminhada inexistente' do
      it 'retorna json de erro' do
        post :start_walk, params: { id: 'x' }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'quando inicia uma caminhada cancelada' do
      let!(:dgw) { create(:dog_walking, status: :cancelled) }
      it 'retorna json de erro' do
        post :start_walk, params: { id: dgw.id }
        expect(response).to have_http_status(:error)
      end
    end

    context 'quando inicia uma caminhada em andamento' do
      let!(:dgw) { create(:dog_walking, status: :started) }
      it 'retorna json de erro' do
        post :start_walk, params: { id: dgw.id }
        expect(response).to have_http_status(:error)
      end
    end
  end

  describe 'POST #finish_walk' do
    context 'quando conclui uma caminhada agendada' do
      let!(:dgw) { create(:dog_walking) }
      it 'retorna json de erro' do
        post :finish_walk, params: { id: dgw.id }
        expect(response).to have_http_status(:error)
      end
    end

    context 'quando conclui uma caminhada inexistente' do
      it 'retorna json de erro' do
        post :finish_walk, params: { id: 'x' }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'quando conclui uma caminhada cancelada' do
      let!(:dgw) { create(:dog_walking, status: :cancelled) }
      it 'retorna json de erro' do
        post :finish_walk, params: { id: dgw.id }
        expect(response).to have_http_status(:error)
      end
    end

    context 'quando conclui uma caminhada em andamento' do
      let!(:dgw) { create(:dog_walking, status: :started) }
      it 'retorna sucesso' do
        post :finish_walk, params: { id: dgw.id }
        expect(response).to be_successful
      end
    end
  end

  describe 'POST #cancel_walk' do
    context 'quando cancela uma caminhada agendada' do
      let!(:dgw) { create(:dog_walking) }
      it 'retorna sucesso' do
        post :cancel_walk, params: { id: dgw.id }
        expect(response).to be_successful
      end
    end

    context 'quando cancela uma caminhada inexistente' do
      it 'retorna json de erro' do
        post :cancel_walk, params: { id: 'x' }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'quando cancela uma caminhada cancelada' do
      let!(:dgw) { create(:dog_walking, status: :cancelled) }
      it 'retorna json de erro' do
        post :cancel_walk, params: { id: dgw.id }
        expect(response).to have_http_status(:error)
      end
    end

    context 'quando cancela uma caminhada em andamento' do
      let!(:dgw) { create(:dog_walking, status: :started) }
      it 'retorna json de erro' do
        post :cancel_walk, params: { id: dgw.id }
        expect(response).to have_http_status(:error)
      end
    end
  end
end
