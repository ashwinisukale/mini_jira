# frozen_string_literal: true

class Todo < ApplicationRecord
  enum status: %w[open in_progress done]
  belongs_to :project
  has_one :user_todo
  has_one :user, through: :user_todo

  validates :name, presence: true
  
  def update_with_user(params)
    update(params.except(:user_id))
    return if params[:user_id].blank?
    user << User.find(params[:user_id])
  end
end
