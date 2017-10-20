class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :address
      t.string :email
      t.string :home_number
      t.string :phone_numer
      t.string :blood_type
      t.string :annotations
      t.timestamps
    end
  end
end
