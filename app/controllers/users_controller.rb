class UsersController < ApplicationController

  def home
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
    if @user.valid? && save_with_stripe # || save_with_fortumo || save_with_coinbase
      @user.payment_processor = 'stripe'
      if @user.save
        #UserMailer.welcome_email(@user).deliver      # Uncomment to send welcome email
        flash.now[:success] = "Thank you for payment!"
        redirect_to @user
      else
        render 'new'
      end
    end
  end

	
  def thanks
    redirect_to 'thanks'
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :payment_processor, :token)
  	end
        
end
