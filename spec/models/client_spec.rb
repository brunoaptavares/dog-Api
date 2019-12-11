require 'rails_helper'

RSpec.describe Client, type: :model do
  it { is_expected.to have_many(:pets) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:document) }
end
