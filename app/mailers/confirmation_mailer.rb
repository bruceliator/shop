class ConfirmationMailer < ApplicationMailer
  def confirm_order(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
