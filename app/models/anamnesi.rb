class Anamnesi < ActiveRecord::Base
  
  belongs_to :patient
  
  validates :sp, length: {maximum: 100}
  validates :hea, length: {maximum: 100}
  validates :fog, length: {maximum: 100}
  validates :ape, length: {maximum: 100}
  validates :apa, length: {maximum: 100}
  validates :afa, length: {maximum: 100}
  validates :sv, length: {maximum: 100}
  validates :pa, length: {maximum: 100}
  validates :fr, length: {maximum: 100}
  validates :p, length: {maximum: 100}
  validates :t, length: {maximum: 100}
  validates :fcyp, length: {maximum: 100}
  validates :tc, length: {maximum: 100}
  validates :orl, length: {maximum: 100}
  validates :cp, length: {maximum: 100}
  validates :abd, length: {maximum: 100}
  validates :ext, length: {maximum: 100}
  validates :pyf, length: {maximum: 100}
  validates :idx, length: {maximum: 200}
  validates :tx, length: {maximum: 200}
  validates :annotations, length: {maximum: 200}
  validates :patient_id, presence: true
  
end