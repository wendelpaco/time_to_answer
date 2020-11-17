class Subject < ApplicationRecord
  has_many :questions
  # Kaminari Paginate
  paginates_per 20
end
