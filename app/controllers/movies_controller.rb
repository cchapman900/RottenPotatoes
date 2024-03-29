class MoviesController < ApplicationController
  helper_method :sort_column, :sort_direction  

  def index
    @all_ratings = Movie.valid_ratings
    @selected_ratings = params[:ratings]? params[:ratings].keys : @all_ratings
    @movies = Movie.where('rating IN (?)', @selected_ratings)
    @movies = @movies.order(sort_column + " " + sort_direction)
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
