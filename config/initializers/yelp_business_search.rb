# frozen_string_literal: true

require 'yelp_businesses_search'

YELP_BUSINESSES_SEARCH = YelpBusinessesSearch::Client.new(api_key: ENV['yelp_api_key'])
