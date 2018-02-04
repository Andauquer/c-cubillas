class Appointment < ActiveRecord::Base
  
  belongs_to :patient
  
  validates :idx, length: {maximum: 200}
  validates :tx, length: {maximum: 200}
  validates :annotations, length: {maximum: 200}
  validates :fecha, presence: true
  validates :patient_id, presence: true
  
end