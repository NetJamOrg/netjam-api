class ClipsController < ApplicationController
  def index
    render json: Clip.all
  end
end
