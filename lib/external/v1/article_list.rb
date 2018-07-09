module External
  module V1
    class ArticleList
      include HTTParty

      def initialize
        @base_uri = ENV.fetch(
            'ARTICLES_LIST_URI',
            'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer'
        )
      end

      def get_articles
        response = HTTParty.get(article_list_url)
        handle_failure(response.code)

        to_hash(response.body)
      end

      private

      def handle_failure(response_code)
        return if response_code == 200
        raise "[#{self.class}] - Unsuccessful response. Code: #{response_code}"
      end

      def article_list_url
        @base_uri + '/articles.json'
      end

      def to_hash(payload)
        JSON.parse(payload).with_indifferent_access
      end
    end
  end
end