class Role < ApplicationRecord
	DEFAULT = { admin: 'Admin', developer: 'Developer' }
	has_many :user_roles
  has_many :users, through: :user_roles
end
