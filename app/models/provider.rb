class Provider < ApplicationRecord
  has_many :dog_walkings, dependent: :destroy

  validates :name, :document, presence: true
end
