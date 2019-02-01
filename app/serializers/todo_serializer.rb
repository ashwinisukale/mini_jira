class TodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status
  has_one :project
  has_many :users
end
