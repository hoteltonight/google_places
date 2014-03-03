module GooglePlaces
  class Prediction
    DEFAULT_RADIUS = 1000
    DEFAULT_SENSOR = false

    attr_accessor(
      :description,
      :id,
      :reference,
    )

    def initialize(json_result_object)
      @description = json_result_object['description']
      @id = json_result_object['id']
      @reference = json_result_object['reference']
    end

    def self.list_by_input(input, api_key, options = {})
      lat = options.delete(:lat)
      lng = options.delete(:lng)
      radius = options.delete(:radius) || DEFAULT_RADIUS
      sensor = options.delete(:sensor) || DEFAULT_SENSOR
      types  = options.delete(:types)

      options = {
        :input => input,
        :sensor => sensor,
        :key => api_key,
      }

      if lat && lng
        options[:location] = Location.new(lat, lng).format
        options[:radius] = radius
      end

      # Accept Types as a string or array
      if types
        types = (types.is_a?(Array) ? types.join('|') : types)
        options[:types] = types
      end

      request(:predictions_by_input, options)
    end

    def self.request(method, options)
      response = Request.send(method, options)

      response['predictions'].map do |result|
        self.new(result)
      end
    end
  end
end
