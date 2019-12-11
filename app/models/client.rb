class Client < ApplicationRecord
  has_many :pets, dependent: :destroy

  validates :name, :document, presence: true
end
