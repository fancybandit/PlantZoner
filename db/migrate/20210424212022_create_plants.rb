class CreatePlants < ActiveRecord::Migration[6.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :scientific_name
      t.text :image_link

      t.timestamps null: false
    end
  end
end
