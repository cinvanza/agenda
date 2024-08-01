class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.integer :postal_code
      t.decimal :latitude
      t.decimal :longitude
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
