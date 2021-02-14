class Movie < ActiveRecord::Base
  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    ratings = ratings_list.keys
    if ratings.kind_of?(Array)
      ratings.each do |rating|
        Movie.find_by_rating(rating)
      end
    end
    if ratings == nil
      Movie.all
    end
  end
end
