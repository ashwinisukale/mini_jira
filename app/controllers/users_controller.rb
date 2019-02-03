class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :only_admin

  def index
  	# Returns all the developers
  	users = User.where(admin: false)
  	render json: users
  end
end
