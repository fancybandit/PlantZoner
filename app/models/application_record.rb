require_relative '../../lib/api'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_plants
    plants_hash = API.new.get_plants_data(self.zone_id)
    plants_hash.each do |p|
      plant = Plant.find_by(name: p[0])
      if !plant
      # if plant
      #   self.plants << plant if self.plants.none? {|p| p == plant}
      # else
        plant = Plant.new(name: p[0], scientific_name: p[1][:scientific_name], image_link: p[1][:image_link])
        # self.plants << plant
        plant.save
      end
    end
    self.plants
  end
end