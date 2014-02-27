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
			render json: "logged in"
		end
	end

	def destroy
		log_user_out!
		render :new
	end

	def logged_in
		render json: logged_in?
	end
end
