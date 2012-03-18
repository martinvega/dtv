class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.date :date
      t.string :name
      t.integer :number
      t.string :locality
      t.references :contact_state
      t.references :user

      t.timestamps
    end
  end
end
