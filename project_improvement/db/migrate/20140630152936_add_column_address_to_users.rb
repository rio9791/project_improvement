class AddColumnAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
  end

  def down
  	remove_column :users, :address
  end
end
