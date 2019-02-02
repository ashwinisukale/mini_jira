# frozen_string_literal: true

class UserTodo < ApplicationRecord
  belongs_to :todo
  belongs_to :user
end
