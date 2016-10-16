class ProjectsController < ApplicationController
  before_action :ensure_user_authorized

  def index
    render json:  Project.all
  end
end
