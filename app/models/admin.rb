class Admin < ActiveRecord::Base
  
  has_secure_password
  
  attr_accessor :remember_token, :activation_token, :reset_token
  
  #Esta es una expresion regular para validar el formato que deberia tener un email.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
             length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }
  #Antes de guardar, convierte el email a solo minusculas.
  before_save { self.email = email.downcase }

   # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = Admin.new_token
    update_attribute(:reset_digest,  Admin.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def Admin.new_token
    SecureRandom.urlsafe_base64
  end
  
  def Admin.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private
  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = Admin.new_token
    self.activation_digest = Admin.digest(activation_token)
  end
  
end