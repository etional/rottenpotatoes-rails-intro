class Movie < ActiveRecord::Base
  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    if ratings_list.kind_of?(Array)
      return Movie.where(rating: ratings_list)
    end
    if ratings_list == nil
      return Movie.all
    end
  end
  def self.all_ratings()
  # return all possible values of a movie rating
    return ['G', 'PG', 'PG-13', 'R']
  end
end
