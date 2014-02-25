require 'bcrypt'

class User < ActiveRecord::Base

	before_validation :ensure_session_token
	validates :email, :password_digest, :session_token, presence: true
	validates :email, uniqueness: true

	has_many :words

	def self.find_by_credentials(email, secret)
		user = User.find_by_email(email)

		return nil if user.nil?

		user.has_password?(secret) ? user : nil
	end

	def self.generate_session_token
		SecureRandom.urlsafe_base64(16)
	end

	def has_password?(secret)
		BCrypt::Password.new(self.password_digest).is_password?(secret)
	end

	def password=(secret)
		self.password_digest = BCrypt::Password.create(secret)
	end

	def reset_session_token!
		self.session_token = self.class.generate_session_token
		self.save!
		self.session_token
	end

	private

	def ensure_session_token
		self.session_token ||= self.class.generate_session_token
	end
end
