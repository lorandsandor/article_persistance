# frozen_string_literal: true

require 'rails_helper'

RSpec.describe External::V1::ArticleList do
  let(:article_list) { [{ id: 1, stuff: 'more_stuff' }].to_json }
  let(:response) { double('response', body: article_list, code: 200) }

  before do
    allow(HTTParty).to receive(:get).and_return response
  end

  describe 'initialize' do
    context 'when ARTICLES_LIST_URI is set' do
      let(:uri) { 'my_test_uri' }

      before do
        ENV['ARTICLES_LIST_URI'] = uri
      end

      it 'sets @base_uri to the same value' do
        expect(subject.instance_variable_get(:@base_uri)).to eq uri
      end
    end

    context 'when ARTICLES_LIST_URI is NOT set' do
      let(:uri) { 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer' }

      before do
        ENV['ARTICLES_LIST_URI'] = nil
      end

      it 'sets @base_uri to the default value' do
        expect(subject.instance_variable_get(:@base_uri)).to eq uri
      end
    end
  end

  describe 'get_articles' do
    let(:url) { 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/articles.json' }

    it 'calls the API' do
      expect(HTTParty).to receive(:get).with(url)
      subject.get_articles
    end

    context 'when success' do
      it 'returns an array' do
        expect(subject.get_articles).to be_a Array
      end
    end

    context 'when failure' do
      let(:error) { '[External::V1::ArticleList] - Unsuccessful response. Code: 400' }
      let(:response) { double('response', code: 400) }

      it 'raises an error' do
        expect { subject.get_articles }.to raise_error error
      end
    end
  end
end
