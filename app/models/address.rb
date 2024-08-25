class Address < ApplicationRecord
  belongs_to :contact

  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_full_address?

  def full_address
    [street, city, state, country, postal_code].compact.join(', ')
  end
end
