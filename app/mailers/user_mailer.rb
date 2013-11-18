class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
  	@user = user
  	@url 	= 'http://skilbjo-prod.herokuapp.com/'
  	mail(to: @user.email, subject: 'Thanks for registering!')
  end
end
