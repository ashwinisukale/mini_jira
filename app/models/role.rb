# frozen_string_literal: true

class Role < ApplicationRecord
  DEFAULT = { admin: 'Admin', developer: 'Developer' }.freeze
  has_many :user_roles
  has_many :users, through: :user_roles
end
