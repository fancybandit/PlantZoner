class GardensController < ApplicationController
    before_action :redirect_if_not_logged_in

    def show
        find_garden
    end

    def index
        if params[:user_slug]
            if find_owner
                @gardens = @owner.gardens.sort_by {|g| g.name}
                @zones = @gardens.map do |g|
                    g.growing_zone.name
                end.uniq.sort_by {|x| x[/\d+/].to_i}
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
        garden = Garden.find_by(id: garden_params[:id])
        if garden
            plant = Plant.new(plant_params(:name, :scientific_name, :image_link))
            if plant.save
                garden.plant = plant
                garden.save
                redirect_to user_garden_path(current_user, garden)
            else
                flash[:error] = plant.errors.full_messages.first
                redirect_back(fallback_location: root_path)
            end
        else
            garden = Garden.new(garden_params)
            garden.plant_id = 1 # PLACEHOLDER ID
            if garden.save
                redirect_to new_garden_plant_path(garden)
            else
                flash[:error] = garden.errors.full_messages.first
                redirect_back(fallback_location: root_path)
            end
        end
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

    def find_owner
        @owner = User.find_by_slug(params[:user_slug])
    end

    def find_garden
        @garden = Garden.find_by(id: params[:id])
    end

end