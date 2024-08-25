class PhoneNumber < ApplicationRecord
  belongs_to :contact

  enum kind: { mobile: 0, home: 1, work: 2 }

  validates :number, presence: true
  validates :kind, presence: true
end
