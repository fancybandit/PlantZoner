class PlantsController < ApplicationController

    def show
        @plant = Plant.find_by(id: params[:id])
        if @plant
            @growing_zones = @plant.growing_zones.order(:name).uniq.sort_by {|x| x.name[/\d+/].to_i}
        else
           redirect_to growing_zones_path
        end
    end

    def new
        @garden = Garden.find_by(id: params[:garden_id])
        # @plants = @garden.growing_zone.get_plants
    end

    def create
        binding.pry
        redirect_to plant_path(plant)
    end

    def edit
        @garden = Garden.find_by(id: params[:garden_id])
        @plant = Plant.find_by(id: params[:id])
        # @growing_zones = GrowingZone.order(:name)
    end

    def update
        garden = Garden.find_by(id: params[:garden_id])
        if garden.owner == current_user
            plant = garden.plant
            garden.update(garden_params)
            plant.update(plant_params(:name, :scientific_name, :image_link))
            if garden.save && plant.save
                redirect_to user_garden_path(current_user, garden)
            else
                flash[:error] = "#{garden.errors.full_messages.first if garden.errors}#{plant.errors.full_messages.first if plant.errors}"
                redirect_back(fallback_location: root_path)
            end
        else
            flash[:error] = "You don't have permission to edit another user's resource."
            redirect_back(fallback_location: root_path)
        end
    end

    def delete
        plant = Plant.find_by(id: params[:id])
        plant.destroy
        redirect_to growing_zones_path
    end

    private

    def associate_growing_zones_with_plant(plant)
        growing_zone_ids.each do |i|
            gz = GrowingZone.find_by(zone_id: i)
            gz.plants << plant if gz.plants.none? {|p| p == plant}
        end
    end

    def growing_zone_ids
        params.require(:plant).require(:growing_zone).require(:zone_id)
    end

end