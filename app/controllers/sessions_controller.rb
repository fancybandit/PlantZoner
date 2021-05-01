class SessionsController < ApplicationController

    def home
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    def create
        binding.pry
        user = User.find_by(username: session_params[:username])
        if user && user.authenticate(session_params[:password])
            session[:user_slug] = user.slugify
            redirect_to user_path(user.slug)
        else
            if user
                flash[:error] = "Invalid password."
            else
                flash[:error] = "Invalid username and password."
            end
            redirect_to login_path
        end
    end

    private

    def session_params
        params.require(:user).permit(:username, :password)
    end

    def auth
        request.env['omniauth.auth']
    end

end