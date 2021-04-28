class UsersController < ApplicationController

    def show
        redirect_if_not_logged_in
        find_user
        redirect_to '/' if !@user
    end

    def new
        if logged_in?
            redirect_to user_path(session[:user_id])
        else
            @user = User.new
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] = @user.errors.full_messages.first
            render :new
        end
    end

    def edit
        find_user
    end

    def update
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def find_user
        @user = User.find_by(id: params[:id])
    end

    def slug
        self.username.gsub(/[^0-9A-Za-z ]/, '').downcase.split(' ').join('-')
    end
    
    def find_by_slug(slug)
        self.all.detect do |obj|
            obj.slug == slug
        end
    end

end