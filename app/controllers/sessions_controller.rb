class SessionsController < ApplicationController

    def home
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    def create
        user = User.find_by(username: session_params[:username])
        if user && user.authenticate(session_params[:password])
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            if user
                flash[:error] = "Invalid password."
            else
                flash[:error] = "Invalid username."
            end
            redirect_to login_path
        end
    end

    private

    def session_params
        params.require(:user).permit(:username, :password)
    end
end