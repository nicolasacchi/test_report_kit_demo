class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :minsan_code
      t.integer :price_cents
      t.integer :stock
      t.string :category
      t.boolean :active

      t.timestamps
    end
  end
end
