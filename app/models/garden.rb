class Garden < ApplicationRecord
  belongs_to :owner
  belongs_to :growing_zone
  belongs_to :plant
end
