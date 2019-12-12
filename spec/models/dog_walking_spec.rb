require 'rails_helper'

RSpec.describe DogWalking, type: :model do
  it { is_expected.to belong_to(:provider) }
  it { is_expected.to have_and_belong_to_many(:pets) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:schedule_date) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_presence_of(:latitude) }
  it { is_expected.to validate_presence_of(:longitude) }

  let(:params) do
    {
      schedule_date: Time.zone.today,
      price: 10.0,
      duration: 30,
      latitude: '112233',
      longitude: '000000',
      ini_date: Time.current,
      end_date: Time.current + 1.hour
    }
  end

  describe 'transicao de status' do
    let(:dog_walking) { DogWalking.new }

    it 'has default status' do
      expect(dog_walking.status).to eq('scheduled')
      expect(dog_walking).to transition_from(:scheduled).to(:started).
        on_event(:started)
      expect(dog_walking).to transition_from(:started).to(:finished).
        on_event(:finished)
      expect(dog_walking).to transition_from(:scheduled).to(:cancelled).
        on_event(:cancelled)
    end
  end

  describe '.initialize' do
    subject { DogWalking.new(params) }

    context 'com parametros validos' do
      let(:provider) { build(:provider) }

      it 'deve instanciar o objeto sem erros' do
        subject.provider = provider
        expect(subject.status).to eq('scheduled')
        expect(subject.schedule_date).to eq(params[:schedule_date])
        expect(subject.price).to eq(params[:price])
        expect(subject.duration).to eq(params[:duration])
        expect(subject.latitude).to eq(params[:latitude])
        expect(subject.longitude).to eq(params[:longitude])
        expect(subject.ini_date).to eq(params[:ini_date])
        expect(subject.end_date).to eq(params[:end_date])
        expect(subject.valid?).to be_truthy
        expect(subject.errors).to be_empty
      end
    end

    context 'com parametros invalidos' do
      it 'deve instanciar o objeto com erros' do
        expect(subject.valid?).to be_falsey
        expect(subject.errors).to have(1).errors_on(:provider)
      end
    end
  end

  describe '#actual_duration' do
    context 'quando a caminhada foi concluida' do
      subject { DogWalking.new(params).actual_duration }

      it 'deve retornar a diferenca de tempo entre inicio e fim da caminhada' do
        expect(subject).to eq(60)
      end
    end

    context 'quando a caminhada nao foi concluida' do
      subject { DogWalking.new.actual_duration }

      it 'deve retornar 0' do
        expect(subject).to eq(0)
      end
    end
  end
end
