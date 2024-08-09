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

# Crear un usuario
user = User.create!(
  email: 'usuario@ejemplo.com',
  password: 'password123',
  password_confirmation: 'password123'
)

# Crear 20 contactos
20.times do
  contact = Contact.create!(
    user: user,
    full_name: Faker::Name.name,
    nickname: Faker::Name.first_name,
    # email: Faker::Internet.email(domain: 'example.com'),
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65) # Coma añadida aquí
  )

  # Crear una dirección para cada contacto
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

  # Crear 1-3 números de teléfono para cada contacto
  rand(1..3).times do
    PhoneNumber.create!(
      contact: contact,
      number: Faker::PhoneNumber.phone_number.gsub(/\D/, '').to_i
    )
  end
end

puts "Seed completado: 1 usuario, 20 contactos con direcciones y números de teléfono creados."
