class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :set_subjects, only: [:new, :edit, :create]

  def index
    @questions = Question.includes(:subject).order(id: :desc).page(params[:page])
  end

  def edit
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params_question)
    if @question.save()
        redirect_to admins_backoffice_questions_path, notice: t("notice.question.create")
    else
        render :new
    end
  end

  def update
    if @question.update(params_question)
        redirect_to admins_backoffice_questions_path, notice: t("notice.question.update")
    else
        render :edit
    end
  end

  def destroy
    if @question.destroy
        redirect_to admins_backoffice_questions_path, notice: t("notice.question.destroy")
    else
      render :index
    end
  end

private

  def set_question
    @question = Question.find(params[:id])
  end

  def params_question
    params.require(:question).permit(:description, :subject_id, 
                  answers_attributes: [:id, :description, :correct, :_destroy])
  end

  def set_subjects
    @subjects = Subject.all.pluck(:description, :id)
  end
  
end