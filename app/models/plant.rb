class Plant < ApplicationRecord
    has_many :gardens
    has_many :growing_zones, through: :gardens
    has_many :owners, class_name: "User", through: :gardens
end