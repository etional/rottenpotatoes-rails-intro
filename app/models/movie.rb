class Movie < ActiveRecord::Base
  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    if ratings_list.kind_of?(Array)
      ratings_list.each do |rating|
        Movie.find_all_by_rating(rating)
      end
    end
    if ratings_list == nil
      Movie.all
    end
  end
end
