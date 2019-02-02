# frozen_string_literal: true

class TodoUserProject < ApplicationRecord
  belongs_to :todo
  belongs_to :user_project
end
