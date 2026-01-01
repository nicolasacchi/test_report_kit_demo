class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :customer_email
      t.string :status
      t.integer :total_cents
      t.string :payment_method
      t.datetime :shipped_at
      t.text :notes

      t.timestamps
    end
  end
end
