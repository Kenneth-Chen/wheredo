class UserMailer < ActionMailer::Base
  default from: "WhereDoIDrive <support@wheredoidrive.com>"
  layout "customer_email"

  def contact_us(name, email, message)
    @message = message
    from = "#{name} <#{email}>"
    mail(to: "wheredoidrive@gmail.com", from: from, subject: "Question From Website")
  end
end
