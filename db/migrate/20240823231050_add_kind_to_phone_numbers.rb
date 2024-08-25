class AddKindToPhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    add_column :phone_numbers, :kind, :integer, default: 0
  end
end
