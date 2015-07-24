class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total, :precision => 8, :scale => 2
      t.date :completed
      t.string :state
      t.references :customer, index: true, foreign_key: true
      t.references :billing_address, index: true, foreign_key: true
      t.references :shipping_address, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
