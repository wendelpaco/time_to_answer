class Site::SearchController < SiteController
  def questions
    @questions = Question._search_(params[:page], params[:q])
                         .last_questions(params[:page])
  end
  def subject
    @questions = Question._search_subject_(params[:page], params[:subject_id])
                         .last_questions(params[:page])
  end
end
