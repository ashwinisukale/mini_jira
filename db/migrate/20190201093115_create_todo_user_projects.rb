# frozen_string_literal: true

class CreateTodoUserProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_user_projects do |t|
      t.references :todo, foreign_key: true
      t.references :user_project, foreign_key: true

      t.timestamps
    end
  end
end
