require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:article) { Article.new(id: 1, likes: 0) }

  describe 'index' do
    it 'sets the article list' do
      get :index
      expect(subject.instance_variable_get(:@articles)).to eq []
    end
  end

  describe 'update' do
    before do
      allow(Article).to receive(:find_by_id).with(article.id.to_s).and_return article
      allow(article).to receive(:save).and_return true

      put :update, params: { id: 1 }
    end

    it 'filters parameters' do
      expect { put :update, id: 1, random: 'param' }.to raise_error
    end

    it 'sets @article' do
      expect(subject.instance_variable_get(:@article)).to eq article
    end

    it 'updates the number of likes' do
      expect(subject.instance_variable_get(:@article).likes).to eq 1
    end

    it 'redirects to index' do
      expect(response).to redirect_to '/articles'
    end
  end
end
