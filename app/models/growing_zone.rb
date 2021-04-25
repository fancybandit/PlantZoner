class GrowingZone < ApplicationRecord
    has_many :gardens
    has_many :plants, through: :gardens
    has_many :owners, class_name: "User", through: :gardens
end