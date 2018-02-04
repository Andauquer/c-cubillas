class CreateNewAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :idx
      t.string :tx
      t.string :annotations
      t.datetime :fecha
      t.integer :patient_id
      t.timestamps
    end
  end
end
