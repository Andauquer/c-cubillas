class Patient < ActiveRecord::Base
  
  has_many :appointments
  
  #Esta es una expresion regular para validar el formato que deberia tener un email.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, allow_blank: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, 
              format: { with: VALID_EMAIL_REGEX }
              
  #Antes de guardar, convierte el email a solo minusculas.
  before_save { self.email = email.downcase }
              
  validates :first_name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :age, presence: true
  validates :address, length: {maximum: 80}
  validates :annotations, length: {maximum: 400}
  
end