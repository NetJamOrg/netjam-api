class ProjectsController < ApplicationController
  before_action :ensure_user_authorized

  def index
    render json:  Project.where(owner_id: current_user_hash[:id])
  end
end
