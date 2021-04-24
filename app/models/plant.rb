class Plant < ApplicationRecord
    has_many :gardens
    has_many :growing_zones, through: :gardens
end