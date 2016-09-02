class Lender < ApplicationRecord

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	has_secure_password
	has_many :history, as: :historyable
	has_many :borrowers, through: :history

	validates :first_name, :last_name, :email, presence: true
	validates :money, :numericality => { :greater_than_or_equal_to => 0 }
	validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	validates :password, length: { minimum: 6 }, :if => :should_validate_password?

	before_save do
		self.email.downcase!
	end

	def should_validate_password?
		updating_password || new_record?
	end

	attr_accessor :updating_password
end