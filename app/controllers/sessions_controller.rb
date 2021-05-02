class SessionsController < ApplicationController

    def home
        session.clear if !current_user
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    def create
        if auth
            user = find_or_create_user_by_auth_uid(auth['uid'])
            user.save
            session[:user_slug] = user.slug
            redirect_to user_path(user.slug)
        else
            user = User.find_by(username: session_params[:username])
            if user && user.authenticate(session_params[:password])
                session[:user_slug] = user.slugify
                redirect_to user_path(user)
            else
                if user
                    flash[:error] = "Invalid password."
                else
                    flash[:error] = "Invalid username and password."
                end
                redirect_to login_path
            end
        end
    end

    private

    def session_params
        params.require(:user).permit(:username, :password)
    end

    def auth
        request.env['omniauth.auth']
    end

    def find_or_create_user_by_auth_uid(uid)
        User.find_or_create_by(uid: uid) do |u|
            if User.find_by(username: auth['info']['nickname'])
                u.username = "#{auth['info']['nickname']}_GitHub"
            else
                u.username = auth['info']['nickname']
            end
            if auth['info']['email']
                u.email = auth['info']['email']
            else
                u.email = "#{uid}@plantzoner.com"
            end
            u.password = ENV['AUTH_USER_PASSWORD']
            u.slug = auth['info']['nickname'].gsub(/[^0-9A-Za-z ]/, '').downcase.split(' ').join('-')
        end
    end

end