class Lender < ApplicationRecord

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	has_secure_password
	has_many :history, as: :historyable

	validates :first_name, :last_name, :email, :password, presence: true
	validates :money, :numericality => { :greater_than_or_equal_to => 0 }
	validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }

	before_save do
		self.email.downcase!
	end
end
