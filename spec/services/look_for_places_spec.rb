# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LookForPlaces do
  subject { described_class.call(search_params) }

  let(:search_params) do
    {
      query: 'coffee',
      location: 'NY',
      offset: 20
    }
  end

  let(:sample_business) do
    {
      id: 'N8ZXXxn0RbLo97xoT19RTg',
      name: 'Plowshares Coffee Roasters',
      image_url: 'https://s3-media4.fl.yelpcdn.com/bphoto/JWts-f6iF9bas51p21RzuQ/o.jpg',
      rating: 4.0,
      location: {
        display_address: [
          '2730 Broadway',
          'New York, NY 10025'
        ]
      }
    }
  end

  let(:yelp_response) do
    {
      businesses: [sample_business],
      total: 1
    }.to_json
  end

  before do
    allow(YELP_BUSINESSES_SEARCH).to receive(:lookup).and_return(yelp_response)
  end

  it 'uses yelp client' do
    subject
    expect(YELP_BUSINESSES_SEARCH).to have_received(:lookup)
  end

  it 'returns total count as first element' do
    expect(subject.first).to eq 1
  end

  it 'returns array of found places as last element' do
    expect(subject.last[0]).to be_kind_of(FoundPlace)
  end

  it 'casches results at query-based key' do
    expect(Rails.cache).to receive(:fetch).with('search/coffee/ny/20', { expires_in: 24.hours })
    subject
  end
end
