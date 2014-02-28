require 'spec_helper'

describe GooglePlaces::Prediction, '.list_by_input' do
  use_vcr_cassette 'list_predictions'

  it "should be a collection of Prediction" do
    collection = GooglePlaces::Prediction.list_by_input('query', api_key)

    collection.map(&:class).uniq.should == [GooglePlaces::Prediction]
  end
end
