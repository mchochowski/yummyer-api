# frozen_string_literal: true

class FoundPlace
  include ActiveModel::Model

  attr_accessor :id, :name, :image_url, :location, :rating
end
