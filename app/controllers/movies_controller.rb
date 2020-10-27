class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
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


  private

  def fetch_movies(title)
    RestClient.get "http://www.omdbapi.com/?s=#{title}&apikey=#{ENV["OMDB_APIKEY"]}"
  end
end
