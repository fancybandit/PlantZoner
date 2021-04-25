class User < ApplicationRecord
    has_many :gardens, foreign_key: "owner_id"
    has_many :plants, through: :gardens
    has_many :growing_zones, through: :gardens
end