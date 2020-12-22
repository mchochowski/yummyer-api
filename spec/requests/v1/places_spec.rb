# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Places' do
  describe '#index' do
    let(:host) { 'http://www.example.com' }
    let(:query) { 'coffee' }
    let(:location) { 'NY' }

    let(:response_json) { File.read("#{Rails.root}/spec/files/example_search_response.json") }

    before do
      allow(YELP_BUSINESSES_SEARCH).to receive(:lookup).and_return(response_json)
    end

    context 'first page' do
      let(:path) { "/v1/places?search[query]=#{query}&search[location]=#{location}" }

      it 'is successful' do
        get path
        expect(response).to be_ok
      end

      it 'lists correct number of entities' do
        get path
        expect(parsed_response['data'].size).to eq 20
      end

      it 'lists entities of correc type' do
        get path
        expect(parsed_response['data'].sample['type']).to eq 'found_place'
      end

      it 'returns total number of results' do
        get path
        expect(parsed_response['meta']['total']).to eq 49
      end

      it 'has next link' do
        get path
        expect(parsed_response['links']['next'])
          .to eq "#{host}/v1/places?limit=20&location=#{location}&offset=20&query=#{query}"
      end

      it 'does not have prev link' do
        get path
        expect(parsed_response['links']['prev']).to be_nil
      end
    end

    context 'second page' do
      let(:path) { "/v1/places?search[query]=#{query}&search[location]=#{location}&offset=20" }

      it 'is successful' do
        get path
        expect(response).to be_ok
      end

      it 'lists correct number of entities' do
        get path
        expect(parsed_response['data'].size).to eq 20
      end

      it 'lists entities of correc type' do
        get path
        expect(parsed_response['data'].sample['type']).to eq 'found_place'
      end

      it 'returns total number of results' do
        get path
        expect(parsed_response['meta']['total']).to eq 49
      end

      it 'has next link' do
        get path
        expect(parsed_response['links']['next'])
          .to eq "#{host}/v1/places?limit=20&location=#{location}&offset=40&query=#{query}"
      end

      it 'has prev link' do
        get path
        expect(parsed_response['links']['prev'])
          .to eq "#{host}/v1/places?limit=20&location=#{location}&offset=0&query=#{query}"
      end
    end

    context 'last page' do
      let(:path) { "/v1/places?search[query]=#{query}&search[location]=#{location}&offset=40" }

      it 'is successful' do
        get path
        expect(response).to be_ok
      end

      it 'lists correct number of entities' do
        get path
        expect(parsed_response['data'].size).to eq 20
      end

      it 'lists entities of correc type' do
        get path
        expect(parsed_response['data'].sample['type']).to eq 'found_place'
      end

      it 'returns total number of results' do
        get path
        expect(parsed_response['meta']['total']).to eq 49
      end

      it 'does not have next link' do
        get path
        expect(parsed_response['links']['next']).to be_nil
      end

      it 'has prev link' do
        get path
        expect(parsed_response['links']['prev'])
          .to eq "#{host}/v1/places?limit=20&location=#{location}&offset=20&query=#{query}"
      end
    end
  end
end
