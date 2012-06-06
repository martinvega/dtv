class AddPaymentFormToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :payment_form, :string
  end
end
