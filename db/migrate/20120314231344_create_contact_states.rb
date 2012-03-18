class CreateContactStates < ActiveRecord::Migration
  def change
    create_table :contact_states do |t|
      t.string :state
      t.text :comment

      t.timestamps
    end
  end
end
