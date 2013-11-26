class User < ActiveRecord::Base
	before_save { self.email = email.downcase }

	attr_accessor :name, :email, :ptoken

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX } 
									#	,uniqueness: { case_sensitive: false }
	validates :payment_processor, presence: true, length: { minimum: 2 }
	validates :ptoken, presence: true, length: { minimum: 2 }





end
