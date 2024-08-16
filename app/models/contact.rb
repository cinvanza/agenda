class Contact < ApplicationRecord
  belongs_to :user
  has_many :phone_numbers, dependent: :destroy
  has_many :addresses, dependent: :destroy

  # https://api.rubyonrails.org/v7.1.3.4/classes/ActiveRecord/NestedAttributes/ClassMethods.html
  accepts_nested_attributes_for :phone_numbers, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :addresses, allow_destroy: true

  validates :full_name, presence: true, uniqueness: { case_sensitive: false }
  validates :full_name, length: { minimum: 3 }
  # validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
end
