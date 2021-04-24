class CreateGardens < ActiveRecord::Migration[6.1]
  def change
    create_table :gardens do |t|
      t.references :owner, null: false, foreign_key: {to_table: :users, on_delete: :cascade}
      t.references :growing_zone, null: false, foreign_key: {on_delete: :cascade}
      t.references :plant, null: false, foreign_key: {on_delete: :cascade}
      t.string :name

      t.timestamps null: false
    end
  end
end
