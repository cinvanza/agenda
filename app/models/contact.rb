class Contact < ApplicationRecord
  belongs_to :user
  has_many :phone_numbers, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :full_name, presence: true, uniqueness: { case_sensitive: false }
  validates :full_name, length: { minimum: 3 }
  validates :email, format: { with: /\A.*@.*\.com\z/ }

end
