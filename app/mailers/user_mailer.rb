class UserMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(from: @email,
         to: 'rena.azevedo.carvalho@gmail.com',
         subject: 'New Visitor\'s Email')
  end
end
