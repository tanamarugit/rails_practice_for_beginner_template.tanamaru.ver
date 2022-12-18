class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.question_id = params[:question_id]
    if @answer.save
      redirect_to question_path(params[:question_id])	, notice: '回答しました。'
    else
      @question = Question.find(params[:question_id])
      flash.now[:alert] = "回答に失敗しました。"
      render question_path(params[:question_id])
    end
  end


  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end
