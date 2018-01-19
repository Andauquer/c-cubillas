class AddPatientIdToCitas < ActiveRecord::Migration
  def change
    add_column :citas, :patient_id, :integer
  end
end
