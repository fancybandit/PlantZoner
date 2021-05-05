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
        if @owner == current_user
            @garden = @owner.gardens.find_by(id: params[:id])
            if @garden.nil?
                flash[:error] = "The specified garden does not exist."
                redirect_to user_gardens_path(@owner)
            end
        else
            flash[:error] = "The specified user does not exist."
            redirect_back(fallback_location: root_path)
        end
    end

    def update
        find_owner
        if @owner == current_user
            garden = Garden.find_by(id: params[:id])
            garden.update(garden_params)
            if garden.save
                redirect_to edit_garden_plant_path(garden, garden.plant)
            else
                flash[:error] = garden.errors.full_messages.first
                redirect_back(fallback_location: root_path)
            end
        else
            flash[:error] = "You don't have permission to edit another user's resource."
            redirect_back(fallback_location: root_path)
        end
    end

    def delete
        find_owner
        if @owner == current_user
            garden = Garden.find_by(id: params[:id])
            garden.destroy if garden
            redirect_to user_gardens_path(current_user.slug)
        else
            flash[:error] = "You don't have permission to delete this user's resource"
            redirect_back(fallback_location: root_path)
        end
    end

    private

    def find_owner
        @owner = User.find_by_slug(params[:user_slug])
    end

    def find_garden
        @garden = Garden.find_by(id: params[:id])
    end

end