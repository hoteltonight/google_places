module GooglePlaces
  class Prediction
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
      options = {
        :input => input,
        :sensor => false,
        :key => api_key
      }

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
