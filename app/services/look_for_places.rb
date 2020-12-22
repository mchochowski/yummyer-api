# frozen_string_literal: true

class LookForPlaces
  include Callable

  CASH_EXPIRY_TIME = 24.hours

  def initialize(search_params)
    @search_params = search_params
  end

  def call
    Rails.cache.fetch(cache_key, expires_in: CASH_EXPIRY_TIME) do
      [yelp_results['total'], places]
    end
  end

  private

  def places
    yelp_results['businesses'].map do |place|
      FoundPlace.new(id: place['id'],
                     name: place['name'],
                     image_url: place['image_url'],
                     location: place['location']['display_address'].join(', '),
                     rating: place['rating'])
    end
  end

  def yelp_results
    @yelp_results ||= Oj.load(YELP_BUSINESSES_SEARCH.lookup(@search_params))
  end

  def cache_key
    "search/#{@search_params.values.join('/').downcase}"
  end
end
