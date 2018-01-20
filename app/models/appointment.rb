class Appointment < ActiveRecord::Base
  
  belongs_to :patient
  
  validates :symptoms, length: {maximum: 200}
  validates :medicines, length: {maximum: 200}
  validates :cares, length: {maximum: 200}
  validates :annotations, length: {maximum: 400}
  
end