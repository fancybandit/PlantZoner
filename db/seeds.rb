# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative '../lib/api'

zone_ids = [10, 11, 12, 13, 14, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 40, 41, 42, 43, 50, 51, 60, 61, 62, 63, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 90, 91]

zone_ids.each do |zone_id|

    growing_zone = GrowingZone.find_by(zone_id: zone_id)
    if !growing_zone
        name = API.new.get_zone_name(zone_id)
        growing_zone = GrowingZone.new(name: name, zone_id: zone_id)
        growing_zone.save
    end

end