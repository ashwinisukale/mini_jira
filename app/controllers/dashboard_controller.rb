class DashboardController < ApplicationController
	before_action :authenticate_user!
	before_action :only_admin, except: [:user_data]

  def data
  	array = []
  	if project_params[:by_user]
	  	User.where(admin: false).left_joins(:todos).includes(:todos).distinct.each do |user|
	  		array << { "name" => user.name, "todos" => user.todos.group_by(&:status) }
	  	end
  	else
      condition = project_params[:project_id].present? ? Project.where(id: project_params[:project_id
      ]) : Project.all
  		condition.left_joins(:todos).includes(:todos).distinct.each do |project|
	  		array << { "name" => project.name, "todos" => project.todos.group_by(&:status) }
	  	end
  	end
  	render json: array
  end

  def user_data
  	array = []
  	User.where(admin: false, id: current_user.id).left_joins(:todos).includes(:todos).distinct.each do |user|
  		array << { "name" => user.name, "todos" => user.todos.group_by(&:status) }
  	end
  	render json: array
  end

  private

  # Only allow a trusted parameter "white list" through.
    def project_params
      params.permit(:by_project,:by_user, :user_id, :project_id)
    end
end
