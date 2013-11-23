class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	#validates_presence_of :ptoken

	attr_accessor :name, :email, :ptoken
	attr_accessor :ptoken

#	validates :name, presence: true, length: { maximum: 50 }
#	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
#										uniqueness: { case_sensitive: false }
#	validates :payment_processor, presence: true, length: { minimum: 2 }
#	validates :payment_token, presence: true, length: { minimum: 2 }



  def save_with_fortumo
  end

  def save_with_dwolla
  end

  def save_with_coinbase
  end


end
