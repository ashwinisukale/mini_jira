# frozen_string_literal: true

class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[show update destroy]

  # GET /todos
  def index
    @todos = Todo.all

    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update_with_user(todo_user_params)
      p @todo
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todo_user_params
      params.require(:todo).permit(:name, :description, :status, :project_id).tap do |whitelisted|
        whitelisted[:user_ids] = params[:user_ids]
      end
    end

    def todo_params
      todo_user_params.except(:user_ids)
    end
end
