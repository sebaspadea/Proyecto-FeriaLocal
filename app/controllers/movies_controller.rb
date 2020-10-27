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

  def show
    @movie = JSON.parse(show_movie(params[:id]))
  end


  private

  def fetch_movies(title)
    RestClient.get "http://www.omdbapi.com/?s=#{title}&apikey=#{ENV["OMDB_APIKEY"]}"
  end

  def show_movie(id)
    RestClient.get "http://www.omdbapi.com/?i=#{id}&apikey=#{ENV["OMDB_APIKEY"]}"
  end
end
