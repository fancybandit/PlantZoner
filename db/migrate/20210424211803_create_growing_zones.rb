class CreateGrowingZones < ActiveRecord::Migration[6.1]
  def change
    create_table :growing_zones do |t|
      t.string :name
      t.integer :zone_id

      t.timestamps null: false
    end
  end
end
