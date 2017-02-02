class UserMailer < ActionMailer::Base
  default from: "WhereDoIDrive <support@wheredoidrive.com>"
  layout "customer_email"

  def contact_us(name, email, message)
    @message = message
    mail(to: "wheredoidrive@gmail.com", from: "#{@name} <#{@email}>", subject: "Question From Website")
  end
end
