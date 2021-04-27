class GardensController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new
        @garden = Garden.new
    end

    def create
    end

end