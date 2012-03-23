class AddDateToCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :month
    remove_column :campaigns, :year
    add_column :campaigns, :date, :date
  end
end
