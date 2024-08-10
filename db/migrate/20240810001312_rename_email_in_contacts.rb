class RenameEmailInContacts < ActiveRecord::Migration[7.1]
  def change
    rename_column :contacts, :email, :contact_email
  end
end
