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
    end
  end

  def save_with_stripe
    customer = Stripe::Charge.create(:amount => 400, :currency => "usd", :card => @user.ptoken, :description => @user.email)
    #@user.payment_id = customer.id
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    #self.errors.add :base, "There was a problem with your credit card." 
  end

#FORTUMO_IPS = ['79.125.125.1', '79.125.5.205', '79.125.5.95', 'localhost:3000']

def index
  incoming_url = request.referer # this catch the incoming url, including its params <-- not request referer; mess around in testing; something on the request object request.host??
  request.remote_ip

#  if not FORTUMO_IPS.include? request.remote_ip
#    return abort('FORTUMO_IPS: Unknown IP')
#  end

#  if not valid_signature?(params) 
#    return abort('Error: get_signature')
#  end

  @user = User.new(user_params)
  @user.name = params[:sender]
  @user.email = params[:sender]
  @user.product = 'xltest' 
  @user.payment_processor = 'Fortumo'
  @user.ptoken = params[:sender]

  if @user.save && @user.valid?
    flash.now[:success] = "Thank you for payment!"
  end
end

def receive_fortumo
  if (Fortumo_secret.isempty?) || !valid_signature?( incoming_url_params )  # verify signature
    header('HTTP/1.0 403 Forbidden')
    abort('Error: Unknown IP')
  end
end

def valid_signature?( incoming_url_params )
  str = ""
  incoming_url_params.keys.sort.each do |key,value|  #< -- this correct
    if key != 'sig'  # <-- this correct?
      str << "#{key}=#{value}"
    end
  end
  str << Fortumo_secret
  return Fortumo_secret == Digest::MD5.hexdigest(str)

  # # check payment status
  # if ("/failed/".match(incoming_url_params['status']))
  #   # logic for failed payment
  #   puts "payment failed"
  # else
  #   # logic for successful payment (callback to controller)
  # end
end

  def save_with_dwolla
  end

  def save_with_coinbase
  end


  private

  	def user_params
      if params[:user].present?
    	  params.require(:user).permit(:name, :email, :product, :payment_processor, :ptoken)
    	end
    end
end
