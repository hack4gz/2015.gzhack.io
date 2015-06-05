# encoding: utf-8

class WorksController < ApplicationController
  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params
    if @work.save
      flash[:success] = "您的作品已经成功提交，感谢您的配合！"
      redirect_to new_work_path
    else
      flash[:alert] = "作品提交失败，原因：#{@work.errors.full_messages.join(',')}"
      render 'new'
    end
  end

  private
  def work_params
    params.require(:work).permit(:team, :title, :introduction, attachments:[])
  end
end
