class GrowingZone < ApplicationRecord
    has_many :gardens
    has_many :plants, through: :gardens
    has_many :owners, class_name: "User", through: :gardens

    validates :name, presence: true
    validates :zone_id, presence: true, numericality: {only_integer: true, greater_than: 0}
end