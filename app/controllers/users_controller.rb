class UsersController < ApplicationController

attr_accessor :stripe_card_token
attr_accessor :ptoken

  def home
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.product = 'xltest'
    if save_with_stripe # || save_with_fortumo || save_with_coinbase
      #if save_with_stripe
        @user.payment_processor = 'stripe'
        if @user.save
          #UserMailer.welcome_email(@user).deliver      # Uncomment to send welcome email
          flash.now[:success] = "Thank you for payment!"
          #redirect_to 'thanks'
        else
          render 'new'
        end
      #end
    end
  end

  def save_with_stripe
    customer = Stripe::Charge.create(:amount => 400, :currency => "usd", :card => @user.ptoken, :description => @user.email)
    #@user.ptoken = customer.card
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    #self.errors.add :base, "There was a problem with your credit card." 
  end

"""
  @user.valid? &&
  def thanks
    redirect_to 'thanks'
  end
"""
  private

  	def user_params
  		params.require(:user).permit(:name, :email, :product, :payment_processor, :ptoken)
  	end

end
