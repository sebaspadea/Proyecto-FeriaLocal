class UsersController < ApplicationController
  before_action :set_movies, only: [:favorites, :pending]
  def favorites
    @favorites = @movies.where(favorite: true)
  end

  def pending
    @pending = @movies.where(pending: true)
  end

  private

  def set_movies
    @movies = current_user.movies
  end
end
