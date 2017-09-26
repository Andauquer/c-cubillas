require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    admin = admins(:michael)
    admin.activation_token = Admin.new_token
    mail = UserMailer.account_activation(admin)
    assert_equal "Account activation", mail.subject
    assert_equal [admin.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match admin.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

  test "password_reset" do
    admin = admins(:michael)
    admin.reset_token = Admin.new_token
    mail = UserMailer.password_reset(admin)
    assert_equal "Password reset", mail.subject
    assert_equal ["noreply@example.com"], mail.from
    assert_match admin.reset_token,        mail.body.encoded
    assert_match CGI.escape(admin.email),  mail.body.encoded
  end
end