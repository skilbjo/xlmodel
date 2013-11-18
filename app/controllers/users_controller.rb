class UsersController < ApplicationController

  def save_with_stripe
    if valid?
      customer = Stripe::Charge.create(
                          :amount => 400,
                          :currency => "usd",
                          :card => stripe_card_token,
                          :description => email)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card." 
  end
	

  def home
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      #UserMailer.welcome_email(@user).deliver #uncomment to send welcome email
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def create
    @payment = Payment.new(params[:payment])
    if @payment.save_with_payment_stripe
      redirect_to @payment, :notice => "Thank you for your payment!"
    else
      render :new
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :payment_processor, :token)
  	end
        
end
