class DashboardController < ApplicationController
	#before_action :authenticate_user!

  def data
  	array = []
  	if project_params[:by_user]
	  	User.where(admin: false).left_joins(:todos).includes(:todos).distinct.each do |user|
	  		array << { user.name => user.todos.group_by(&:status) }
	  	end
  	elsif project_params[:by_project]
  		Project.all.left_joins(:todos).includes(:todos).distinct.each do |project|
	  		array << { project.name => project.todos.group_by(&:status) }
	  	end
  	end
  	render json: array
  end

  private

  # Only allow a trusted parameter "white list" through.
    def project_params
      params.permit(:by_project,:by_user)
    end
end
