class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  
  def index
    if params[:query].present?
      @found = []
      @data = JSON.parse(fetch_movies(params[:query]))
      if(@data["Response"] != "False")
        @data["Search"].each do |m|
          @found << m
        end
      end
    end
  end

  def new
    @movie = Movie.new
  end

  def show
    @movie = JSON.parse(show_movie(params[:id]))
  end

  def create
    @data = JSON.parse(show_movie(params[:id]))
    if params[:favorite] == "true"
      @movie = Movie.new(title: @data["Title"], year: @data["Year"], poster: @data["Poster"], favorite: true, user: current_user)
      if @movie.save
        redirect_to favorites_path(current_user)
      else
        show_path(params[:id])
      end
    else
      @movie = Movie.new(title: @data["Title"], year: @data["Year"], poster: @data["Poster"], pending: true, user: current_user)
      if @movie.save
        redirect_to pending_path(current_user)
      else
        show_path(params[:id])
      end
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.favorite
      @movie.update(favorite: false) 
    else
      @movie.update(favorite: true)
      @movie.update(pending: false)
    end
    redirect_to root_path
  end

  private

  def fetch_movies(title)
    RestClient.get "http://www.omdbapi.com/?s=#{title}&apikey=#{ENV["OMDB_APIKEY"]}"
  end

  def show_movie(id)
    RestClient.get "http://www.omdbapi.com/?i=#{id}&apikey=#{ENV["OMDB_APIKEY"]}"
  end
end