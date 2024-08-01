class Contact < ApplicationRecord
  belongs_to :user
  has_many :phone_numbers, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :full_name, presence: true
end
