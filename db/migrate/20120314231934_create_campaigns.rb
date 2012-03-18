class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
