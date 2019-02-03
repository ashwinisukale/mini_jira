# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_admin
  before_action :set_project, only: %i[show update destroy]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def users
    @users = Project.find(params[:project_id]).users
    render json: @users, each_serializer: UserSerializer
  end

  def todos
    @todos = Project.find(params[:project_id]).todos
    render json: @todos, each_serializer: TodoSerializer
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update_with_users(user_project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_project_params
      params.require(:project).permit(:name, :description).tap do |whitelisted|
        whitelisted[:user_ids] = params[:user_ids]
      end
    end

    def project_params
      user_project_params.except(:user_ids)
    end
end
