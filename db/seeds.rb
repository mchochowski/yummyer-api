# frozen_string_literal: true

5.times do
  User.create(username: Faker::TvShows::BreakingBad.character)
end
