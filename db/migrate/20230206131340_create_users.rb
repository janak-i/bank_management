class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :bank_id
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :age
      t.string :username
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end
