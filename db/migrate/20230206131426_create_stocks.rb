class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :company_name
      t.integer :shares_available
      t.integer :price
      t.timestamps
    end
  end
end
