class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :IFSC_code
      t.string :name
      t.string :address
      t.integer :bank_balance
      t.references :user
      t.references :loan

      t.timestamps
    end
  end
end
