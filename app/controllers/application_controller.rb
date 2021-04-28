class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    private

    def current_user
        @current_user ||= User.find_by_slug(session[:user_slug]) if session[:user_slug]
    end

    def logged_in?
        !!session[:user_slug]
    end

    def redirect_if_not_logged_in
        redirect_to root_path if !logged_in?
    end

end