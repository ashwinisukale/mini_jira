class Todo < ApplicationRecord
	enum status: ['open','in_progress','done']
  belongs_to :project
  has_many :todo_user_projects, dependent: :destroy
  has_many :user_projects, through: :todo_user_projects
  has_many :users, through: :user_projects

  def update_with_user(params)
		update(params.except(:user_ids))		
		return if params[:user_ids].blank?
		assign_user_to_todo(params[:user_ids])
	end

	def assign_user_to_todo(params)
		params.each do |id|
			user = User.where(id: id).first
			return errors.add(:user, "User does not exist") if user.blank?
			user_project = UserProject.where(user_id: id, project_id: project_id).first
			TodoUserProject.where(user_project: user_project, todo: self).first_or_create
		end
	end
end