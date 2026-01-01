class CreatePharmacies < ActiveRecord::Migration[8.1]
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.string :code
      t.boolean :active
      t.boolean :auto_accept_orders

      t.timestamps
    end
  end
end
