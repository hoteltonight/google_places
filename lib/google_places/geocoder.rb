module GooglePlaces
  class Geocoder
    def self.reverse_geocode_by_place_id(place_id, api_key, options = {})
      retry_options = options.delete(:retry_options) || {}

      request_options = {
        :place_id => place_id,
        :key => api_key,
        :retry_options => retry_options,
      }

      response = GooglePlaces::Request.reverse_geocode_by_place_id(request_options)

      Spot.new(response['results'][0], api_key)
    end
  end
end
