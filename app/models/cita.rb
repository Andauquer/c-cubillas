class Cita < ActiveRecord::Base
  
  belongs_to :patient
  
  validates :symptoms, length: {maximum: 100}
  validates :medicines, length: {maximum: 100}
  validates :cares, length: {maximum: 100}
  validates :annotations, length: {maximum: 400}
  
end