FactoryBot.define do
  factory :pet do
    association :client
    name { 'Pet' }
    breed { 'Shitzu' }
  end
end
