class GardensController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        if params[:user_id]
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
        if params[:user_id]
            if find_owner
                #verify is current_user before building a garden
                @garden = @owner.gardens.build(garden_params)
            else
                flash[:error] = "The specified user does not exist."
                @garden = Garden.new
            end
        else
            @garden = Garden.new
        end
    end

    def create
    end

    private

    def garden_params
        params.require(:garden).permit(:name, :owner_id, :plant_id, :growing_zone_id)
    end

    def find_owner
        @owner = User.find_by(id: params[:user_id])
    end

end