class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :todos
  has_many :users
end
