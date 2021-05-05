class UsersController < ApplicationController

    def show
        redirect_if_not_logged_in
        find_user
        redirect_to '/', flash: {error: "Unable to find the user you requested."} if !@user
    end

    def new
        if logged_in?
            find_user
            redirect_to user_path(@user.slug)
        else
            @user = User.new
        end
    end

    def create
        @user = User.new(user_params)
        @user.slug = @user.slugify
        if @user.save
            session[:user_slug] = @user.slug
            redirect_to user_path(@user.slug)
        else
            flash[:error] = @user.errors.full_messages.first
            render :new
        end
    end

    def edit
        redirect_if_not_logged_in
        find_user
        if @user != current_user
            redirect_to users_path, flash: {error: "You don't have permission to access this page!"}
        end
    end

    def update
    end

    def delete
        find_user
        if @user == current_user
            session.clear
            @user.destroy
            flash[:error] = "Your account has been successfully deleted."
            redirect_to root_path
        else
            flash[:error] = "You don't have permission to delete another user!"
            redirect_back(fallback_location: root_path)
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def find_user
        @user = User.find_by_slug(params[:slug])
    end

end