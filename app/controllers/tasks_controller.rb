class TasksController < ApplicationController
  before_action :set_task, only: [:complete]

  # List all incomplete tasks
  def index
    @tasks_incomplete = Task.where(status: 'incomplete')
    @new_task = Task.new
  end

  # Create a new task with an initial status of incomplete
  def create
    @task = Task.new(task_params)
    @task.status = 'incomplete'  # Set status to incomplete
    if @task.save
      redirect_to tasks_path
    else
      render :index
    end
  end

  # Mark a task as complete
  def complete
    @task.update(status: 'complete')
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name)
  end
end
