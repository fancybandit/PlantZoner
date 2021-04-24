class Garden < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :growing_zone
  belongs_to :plant
end