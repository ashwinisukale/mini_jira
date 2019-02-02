# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :user_todos, dependent: :destroy
  has_many :todos, through: :user_todos, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
end
