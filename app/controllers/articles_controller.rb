class ArticlesController < ApplicationController
  def index
    @articles = article_list
  end

  def update
    @article = Article.find_by_id(article_params[:id])

    @article.likes += 1
    @article.save

    redirect_to action: 'index'
  end

  protected

  def article_params
    params.permit(:id)
  end

  def article_list
    []
  end
end
