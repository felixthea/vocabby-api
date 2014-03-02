class SessionsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :cors_preflight_check
	after_filter :cors_set_access_control_headers

	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end

	def new
	end

	def create
		user = User.find_by_credentials(params[:user][:email],
			params[:user][:password])

		if user.nil?
			render :new
		else
			log_user_in!(user)
			render json: user
		end
	end

	def destroy
		log_user_out!
		render :new
	end

	def logged_in
		render json: logged_in?
	end

	def find_current_user
		user = User.find_by_session_token(params[:session_token])
		render json: user
	end
end
