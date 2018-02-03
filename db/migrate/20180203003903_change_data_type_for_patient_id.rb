class ChangeDataTypeForPatientId < ActiveRecord::Migration
  def change
    change_column :anamnesis, :patient_id, 'integer USING CAST(patient_id AS integer)'
  end
end
