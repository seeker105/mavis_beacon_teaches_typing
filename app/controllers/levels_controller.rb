class LevelsController < ApplicationController
  def show
    byebug
    @level = Level.find(params[:id])
  end
end
