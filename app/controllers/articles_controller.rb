# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @persisted = Article.all
    @articles = article_list
  end

  def update
    @article = load_article
    @article.likes += 1
    @article.save

    redirect_to action: 'index'
  end

  protected

  # Loads existing article or create new one (persistance)
  def load_article
    article = Article.find_by_id(article_params[:id])
    article || Article.new(id: article_params[:id])
  end

  # return the external article array
  def article_list
    article_list_getter.get_articles
  end

  # singleton of the getter
  def article_list_getter
    @article_list_getter ||= External::V1::ArticleList.new
  end

  private

  # Only allow needed params from the bad internet
  def article_params
    params.permit(:id)
  end
end
