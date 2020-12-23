class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy ]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(20)
  end

  def create
    @task = current_user.tasks.new(task_params.merge(user_id: current_user.id))

    #確認画面にて戻るボタンを押すと、submitのnameに指定した値(back)をキーに値が入ってくる
    # 値が渡ってくれば戻るボタンが押下されたことになるのでrender :new してあげる
    if params[:back].present?
      render :new
      return
    end

    if (@task.save)
      TaskMailer.creation_email(@task).deliver_now
      #指定しないとデフォルトで対応するviewをrenderする
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスク「#{@task.name}」を削除しました。"
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end


  private

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
