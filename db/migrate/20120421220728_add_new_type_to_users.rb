class AddNewTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category2, :boolean
  end
end
