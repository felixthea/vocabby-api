class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_credentials(params[:user][:email],
			params[:user][:password])

		if user.nil?
			render :new
		else
			log_user_in!(user)
		end
	end

	def destroy
		log_user_out!
		render :new
	end
end
