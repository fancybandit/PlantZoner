class User < ApplicationRecord
    has_many :gardens
    has_many :plants, through: :gardens
    has_many :growing_zones, through: :gardens
end