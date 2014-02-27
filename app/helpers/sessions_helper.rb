module SessionsHelper
	def current_user
		User.find_by_session_token(session[:session_token])
	end

	def log_user_in!(user)
		session[:session_token] = user.reset_session_token!
		redirect_to user_url(user.id)
	end

	def log_user_out!
		current_user.reset_session_token!
		session[:session_token] = nil
	end

	def logged_in?
		!!current_user
	end

end
