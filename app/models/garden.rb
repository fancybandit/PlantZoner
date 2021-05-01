class Garden < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :growing_zone
  belongs_to :plant

  validates :name, presence: true
  validates :plant_id, numericality: {only_integer: true, greater_than: 0}
  validates :owner_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :growing_zone_id, presence: true, numericality: {only_integer: true, greater_than: 0}

  def growing_zone_name=(name)
    self.growing_zone = GrowingZone.find_by(name: name)
  end

  def growing_zone_name
    self.growing_zone ? self.growing_zone.name : nil
  end

  def plant_name=(name)
    self.plant = Plant.find_or_create_by(name: name)
  end

  def plant_name
    self.plant ? self.plant.name : nil
  end
end