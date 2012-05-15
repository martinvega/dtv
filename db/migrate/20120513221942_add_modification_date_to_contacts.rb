class AddModificationDateToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :modification_date, :date
  end
end
