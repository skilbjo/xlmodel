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

FORTUMO_IPS = ['79.125.125.1', '79.125.5.205', '79.125.5.95']

def index
  incoming_url_params = request.query_parameters
  incoming_ip = request.remote_ip # request.env['HTTP_X_FORWARDED_FOR'] #request.remote_ip

  if not FORTUMO_IPS.include? incoming_ip
    puts "not a valid ip"
    puts incoming_ip
    #return abort(incoming_ip)
  end

  if not valid_signature?( incoming_url_params ) 
    return abort('Error: get_signature')
  end

  @user = User.new(user_params) #need to figure out how to submit form and have fortumo pop up come up to store name and email
  @user.email = params['sender']
  @user.product = 'xltest' 
  @user.payment_processor = 'Fortumo'
  @user.ptoken = params['payment_id']

  if @user.save && @user.valid? && params['status'] == 'completed'
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
  attempted_params = ""
  incoming_url_params.sort.each do |key,value|  #< -- this correct
    if key != 'sig'  # <-- this correct?
      attempted_params << "#{key}=#{value}"
    end
  end
  attempted_params << Fortumo_secret

  signature = Digest::MD5.hexdigest(attempted_params)

  return signature == incoming_url_params['sig']

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
      #elsif params['sender'].present?
      #  @user.name = params['sender'] unless params['sender'].nil?
      end
    end
end
