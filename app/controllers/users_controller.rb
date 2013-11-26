class UsersController < ApplicationController

attr_accessor :ptoken

  def home
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.product = 'xltest'  # can be either radio button or link path in future
    if params[:commit] == 'stripe'
      if save_with_stripe # || save_with_fortumo || save_with_coinbase ### this will be radio button
        if @user.save && user.valid?
          #logger.debug "made it pasted save"
          flash.now[:success] = "Thank you for payment!"
          #UserMailer.welcome_email(@user).deliver      # Uncomment to send welcome email          
          #redirect_to 'thanks'
        end
      else
        #render 'new'
      end
    if params[:commit] == 'fortumo'
    end
    end
  end

  def save_with_stripe
    customer = Stripe::Charge.create(:amount => 400, :currency => "usd", :card => @user.ptoken, :description => @user.email)
    #@user.payment_id = customer.id
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    #self.errors.add :base, "There was a problem with your credit card." 
  end


  def save_with_fortumo
  end

  def save_with_dwolla
  end

  def save_with_coinbase
  end


  private

  	def user_params
  		params.require(:user).permit(:name, :email, :product, :payment_processor, :ptoken)
  	end

end
