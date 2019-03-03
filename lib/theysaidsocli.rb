require_relative "theysaidsocli/version"
require "httparty"

module Theysaidsocli

  class RateLimitError < StandardError; end

  class QuoteFetcher

    QOD_URL = "http://quotes.rest/qod.json"
    CATEGORIES_URL = "http://quotes.rest/qod/categories.json"
    QOD_BY_CATEGORY_URL = "http://quotes.rest/qod.json?category="

    def categories
      categories_response = HTTParty.get(CATEGORIES_URL)
      if categories_response.response.code == "429"
        raise RateLimitError
      end
      parse_contents(categories_response)[:categories]
    end

    def qod
      qod_response = HTTParty.get(QOD_URL)
      if qod_response.response.code == "429"
        raise RateLimitError
      end

      parse_contents(qod_response)[:quotes][0][:quote]
    end

    def qod_by_category(category)
      qod_response = HTTParty.get(QOD_BY_CATEGORY_URL + category)
      if qod_response.response.code == "429"
        raise RateLimitError
      end

      parse_contents(qod_response)[:quotes][0][:quote]
    end

    private

    def parse_contents(qod_response)
      json_object = JSON.parse(qod_response.to_s, :symbolize_names => true)
      json_object[:contents]
    end
  end

end
