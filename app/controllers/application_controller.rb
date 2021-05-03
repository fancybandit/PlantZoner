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

    def garden_params
        params.require(:garden).permit(:id, :name, :owner_id, :plant_id, :growing_zone_id, :growing_zone_name, plant: [:name, :scientific_name, :image_link])
    end

    def plant_params(*args)
        params.require(:plant).permit(*args)
    end

end