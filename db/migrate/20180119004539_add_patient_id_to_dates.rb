class AddPatientIdToDates < ActiveRecord::Migration
  def change
    add_column :dates, :patient_id, :integer
  end
end
