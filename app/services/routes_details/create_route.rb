module RoutesDetails
  class CreateRoute

    def initialize(location_ids)
      @alternate_route = false
      @start_location, @end_location, @way_waypoints = find_locations(location_ids)
    end

    def create
      begin
        if @start_location.present? && @end_location.present?
          response = RestClient.get "https://maps.googleapis.com/maps/api/directions/json?#{generate_params}"
          success, message, body  = generate_response(JSON.parse(response.body))
          return success, message , body
        else
          return false, I18n.t("routes.not_found") , nil
        end
      rescue Exception => e
       return false, "Somethhing went wrong", e.backtrace
      end
    end

    def find_locations(location_ids)
      indexed_locations = Location.where(id: location_ids)
      if indexed_locations.present? && indexed_locations.count >= 2
        convert_location_ids = location_ids.map {|id| id.to_i }
        location_in_order = indexed_locations.index_by(&:id).values_at(*convert_location_ids)
        start_location = location_in_order.first
        end_location = location_in_order.last
        way_waypoints = location_in_order[1..-2]
        @alternate_route = true if way_waypoints.count > 1
        return start_location, end_location, way_waypoints
      else
        return false, I18n.t("routes.not_found"), nil
      end
    end

    def generate_params
      if @start_location.present? && @end_location.present?
        params_array = []
        params_array << "origin=#{@start_location.latitude},#{@start_location.longitude}"
        params_array << "destination=#{@end_location.latitude},#{@end_location.longitude}"
        if @way_waypoints.present?
            way_points_string = []
            @way_waypoints.each {|way| way_points_string << "via:#{way.latitude}%2C#{way.longitude}" }
            params_array << "wayponints=#{way_points_string.join("%7C")}"
        end
        params_array <<"alternatives=#{@alternate_route}" if @alternate_route
        params_array << "key=#{Rails.application.secrets.google_api_key}"
        params_array.join("&")
      end
    end

    def generate_response(response)
      map_data = []
      if response["geocoded_waypoints"][0]["geocoder_status"] == "OK"
        routes = response["routes"]
        routes.each do | route |
          route_hash = {}
          legs = route["legs"]
          legs.each do | leg |
            legs_hash = {}
            legs_hash["distance"] = leg["distance"]
            legs_hash["duration"] = leg["duration"]
            legs_hash["end_address"] = legs_hash["end_address"]
            legs_hash["end_location"] = legs_hash["end_location"]
            legs_hash["start_location"] = legs_hash["start_location"]
            legs_hash["start_address"] = legs_hash["start_address"]
            legs_hash["steps"] = legs_hash["steps"]
          end
          route_hash["route"] = legs
          map_data << route_hash
        end
        return true, I18n.t("routes.details"), map_data
      else
        return false, I18n.t("routes.not_found"), nil
      end
    end
  end
end
