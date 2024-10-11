class TasksController < ApplicationController
    # แสดงหน้ารายการงานทั้งหมดที่สถานะ incomplete
    def index
      @tasks = Task.where(status: :incomplete)
      @new_task = Task.new
    end
  
    # สร้าง task ใหม่เมื่อฟอร์มถูกส่ง
    def create
      @task = Task.new(task_params)
      @task.status = :incomplete
  
      if @task.save
        redirect_to tasks_path, notice: 'Task was successfully created.'
      else
        render :index
      end
    end
  
    # ทำเครื่องหมายว่า task เสร็จสมบูรณ์
    def complete
      @task = Task.find(params[:id])
      @task.update(status: :complete)
      redirect_to tasks_path, notice: 'Task marked as complete.'
    end
  
    private
  
    # กำหนดฟิลด์ที่อนุญาตให้ส่งผ่านฟอร์ม
    def task_params
      params.require(:task).permit(:name)
    end
  end
  
