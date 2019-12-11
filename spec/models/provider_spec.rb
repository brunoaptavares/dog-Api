require 'rails_helper'

RSpec.describe Provider, type: :model do
  it { is_expected.to have_many(:dog_walkings) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:document) }
end
