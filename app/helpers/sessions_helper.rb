module SessionsHelper

	def log_in(user)
    session[:current_user_id] = user.id
    self.current_user = user
  end

  def current_user=(user)
	  @current_user = user
	end

	def signed_in?
	  !current_user.nil?
	end

	def current_user
    session[:current_user_id] = nil if User.all.size == 0
	  session[:current_user_id].nil? ? nil : User.find(session[:current_user_id])
	end

	def log_out(user)
		@current_user = nil
		session[:current_user_id] = nil
	end
end
