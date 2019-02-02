# frozen_string_literal: true

class TodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status
  has_one :project
  has_one :user
end
