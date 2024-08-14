# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Asegúrate de tener al menos un usuario en la base de datos
user = User.first || User.create(email: "test@example.com", password: "password")

20.times do
  contact = Contact.create!(
    user: user,
    full_name: Faker::Name.name,
    nickname: Faker::Name.first_name,
    contact_email: Faker::Internet.email,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65)
  )

  Address.create!(
    contact: contact,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    postal_code: Faker::Address.zip_code,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )

  PhoneNumber.create!(
    contact: contact,
    number: Faker::PhoneNumber.subscriber_number(length: 10)
  )
end

puts "20 contacts have been created!"
