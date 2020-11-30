class Site::SearchController < SiteController
  def questions
    @questions = Question._search_(params[:page], params[:q])
                         .last_questions(params[:page])
  end
end
