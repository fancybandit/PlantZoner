class GrowingZonesController < ApplicationController

    def index
        @growing_zones = GrowingZone.order(:created_at)
    end

    def show
        @growing_zone = GrowingZone.find_by(id: params[:id])
        if @growing_zone
            @plants = @growing_zone.get_plants.order(:name)
        else
            redirect_to growing_zones_path
        end
    end

end