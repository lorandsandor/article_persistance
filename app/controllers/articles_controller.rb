class ArticlesController < ApplicationController
  def index
    article_list
  end

  def show
    @article = Article.find_by_id(article_params[:id])
  end

  def update
    @article = Article.find_by_id(article_params[:id])

    @article.like += 1
    @article.save
    
    redirect_to index
  end

  protected

  def article_params
    params.require(:article).permit(:id)
  end

  def article_list
  #
  end
end
