# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  private

  def only_admin
    render json: { message: "Only admin can access this data."} unless current_user.admin?
  end
end
