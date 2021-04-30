class GardensController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        if params[:user_slug]
            if find_owner
                @gardens = @owner.gardens
            else
                flash[:error] = "The specified user does not exist."
                @gardens = Garden.all
            end
        else
            @gardens = Garden.all
        end
    end

    def new
        if find_owner
            if @owner == current_user
                @garden = @owner.gardens.build
            else
                flash[:error] = "You don't have permission to edit another user's resource."
                redirect_back(fallback_location: root_path)
            end
        else
            flash[:error] = "The specified user does not exist."
            redirect_back(fallback_location: root_path)
        end
    end

    def create
    end

    def edit
        find_owner
        if owner.nil?
            flash[:error] = "The specified user does not exist."
            redirect_back(fallback_location: root_path)
        else
            @garden = @owner.gardens.find_by(id: params[:id])
            if @garden.nil?
                flash[:error] = "The specified garden does not exist."
                redirect_to user_garden_path(@owner)
            end
        end
    end

    def update
        @garden = Garden.find_by(params[:id])
        @garden.update(garden_params)
        redirect_to user_garden_path(@garden.owner, @garden)
    end

    private

    def garden_params
        params.require(:garden).permit(:name, :owner_id, :plant_id, :growing_zone_id)
    end

    def find_owner
        @owner = User.find_by_slug(params[:user_slug])
    end

end