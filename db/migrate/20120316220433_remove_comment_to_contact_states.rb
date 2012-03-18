class RemoveCommentToContactStates < ActiveRecord::Migration
  def change
    remove_column :contact_states, :comment
  end
end
