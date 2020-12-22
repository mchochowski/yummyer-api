# frozen_string_literal: true

module V1
  class PlacesController < ApplicationController
    include Pageable

    def index
      total, places = LookForPlaces.call(query_params)
      render json: FoundPlaceSerializer.new(places, page_data(total)).serializable_hash.to_json
    end

    private

    def search_params
      params.require(:search).permit(:query, :location, :latitude, :longitude)
    end

    def query_params(new_offset: nil)
      search_params.merge(limit: limit, offset: new_offset || offset)
    end

    def endpoint_url(*args)
      v1_places_url(*args)
    end
  end
end
