# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
end
