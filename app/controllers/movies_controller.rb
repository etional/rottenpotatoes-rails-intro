class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @ratings_to_show = []
    if params[:home].nil? and params[:commit].nil? # the user got to the home page from someplace else
      if !request.fullpath.include? "movies"
        session.clear
      end
      ratings = session[:ratings]
      header = session[:header]
    else
      ratings = params[:ratings]
      header = params[:header]
      session[:ratings] = params[:ratings]
      session[:header] = params[:header]
    end
    if not ratings.nil?
      ratings_key = ratings.keys
      @ratings_to_show = ratings_key
    end

    @movies = Movie.with_ratings(ratings_key)
    @all_ratings = Movie.all_ratings()

    @ratings_hash = Hash[@ratings_to_show.collect { |rating| [rating, 1]}]
    @title_header = ''
    @release_date_header = ''
    if header == 'title_header'
      @title_header = 'hilite bg-warning'
      @movies = @movies.order('title')
    elsif header == 'release_date_header'
      @release_date_header = 'hilite bg-warning'
      @movies = @movies.order('release_date')
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
