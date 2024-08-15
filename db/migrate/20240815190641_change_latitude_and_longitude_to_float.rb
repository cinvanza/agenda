class ChangeLatitudeAndLongitudeToFloat < ActiveRecord::Migration[7.1]
  def change
    change_column :addresses, :latitude, :float
    change_column :addresses, :longitude, :float
  end
end
