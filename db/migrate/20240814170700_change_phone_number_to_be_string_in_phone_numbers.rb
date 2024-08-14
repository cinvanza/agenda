class ChangePhoneNumberToBeStringInPhoneNumbers < ActiveRecord::Migration[7.1]
  def up
    change_column :phone_numbers, :number, :string
  end

  def down
    change_column :phone_numbers, :number, :integer
  end
end
