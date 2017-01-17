class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def confirm_logged_in
    	if session[:user_id]
    		return true
    	else
    	    flash[:notice] = "You have to login first"
    	    redirect_to(:controller => "access", :action => "login")	
    	end	
    end
end
