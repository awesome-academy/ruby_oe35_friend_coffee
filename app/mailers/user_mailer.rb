class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("mailer.sending.subject_activate")
  end

  def password_reset user
    @user = user

    mail to: user.email, subject: t("mailer.sending.subject_password")
  end
end
