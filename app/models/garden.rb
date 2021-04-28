class Garden < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :growing_zone
  belongs_to :plant

  validates :name, presence: true
  validates :owner_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :plant_id, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :growing_zone_id, presence: true, numericality: {only_integer: true, greater_than: 0}
end