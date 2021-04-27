require 'net/http'
require 'json'
require 'pry'

class API
    
    BASE_URL = "https://trefle.io/api/v1/distributions/"

    def get_zone_name(zone_id)
        json = parse_body("#{zone_id}/?token=#{ENV["API_KEY"]}")
        json["data"]["name"]
    end

    def get_plants_data(zone_id)
        plants_hash = {}
        page_count = get_plant_page_count(zone_id)
        loops = 1
        until loops > page_count
            json = parse_body("#{zone_id}/plants?token=#{ENV["API_KEY"]}&filter[rank]=species&filter[edible]=true&page=#{loops}")
            plant_list = json["data"].uniq {|p| p["id"]}
            plant_list.each do |plant|
                name = plant["common_name"]
                scientific_name = plant["scientific_name"]
                if !name
                    name = scientific_name
                end
                image_link = plant["image_url"]
                plants_hash[name] = {scientific_name: scientific_name, image_link: image_link}
            end
            loops += 1
        end
        plants_hash
    end

    private

    def get_page(endpoint)
        uri = URI(BASE_URL + endpoint)
        Net::HTTP.get_response(uri)
    end

    def parse_body(endpoint)
        body = get_page(endpoint).body
        JSON.parse(body)
    end

    def get_plant_page_count(zone_id)
        json = parse_body("#{zone_id}/plants?token=#{ENV["API_KEY"]}&filter[rank]=species&filter[edible]=true")
        page_count = json["links"]["last"].split("=")[3].split("&")[0].to_i
    end

end