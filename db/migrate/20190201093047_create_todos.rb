# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :name
      t.string :description
      t.integer :status, default: 0
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
