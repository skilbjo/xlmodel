class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  attr_reader :token
  attr_reader :email

  def save_with_stripe
      customer = Stripe::Charge.create(:amount => 400, :currency => "usd", :card => token, :description => email)
      self.token = customer.id
      save!
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card." 
  end

end
