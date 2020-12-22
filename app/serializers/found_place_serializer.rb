# frozen_string_literal: true

class FoundPlaceSerializer
  include JSONAPI::Serializer
  attributes :name, :image_url, :location, :rating
end
