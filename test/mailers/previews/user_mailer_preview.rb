class UserMailerPreview < ActionMailer::Preview
  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    admin = Admin.first
    admin.reset_token = Admin.new_token
    UserMailer.password_reset(admin)
  end
end