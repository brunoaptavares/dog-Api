FactoryBot.define do
  factory :dog_walking do
    association :provider
    schedule_date { Time.zone.today }
    price { 10.0 }
    duration { 30 }
    latitude { '000000' }
    longitude { '1111111' }
    ini_date { Time.current }
    end_date { Time.current + 1.hour }
  end
end
