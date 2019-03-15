require_relative "theysaidsocli/version"
require "httparty"

module Theysaidsocli

  class RateLimitError < StandardError; end

  class QuoteFetcher

    QOD_URL = "http://quotes.rest/qod.json"
    CATEGORIES_URL = "http://quotes.rest/qod/categories.json"

    def categories
      categories_response = HTTParty.get(CATEGORIES_URL)
      raise RateLimitError if rate_limited?(categories_response)

      parse_contents(categories_response)[:categories]
    end

    def qod(category = nil)
      qod_response = HTTParty.get(category ? QOD_URL+"?category=#{category}" : QOD_URL)
      raise RateLimitError if rate_limited?(qod_response)

      response = parse_contents(qod_response)[:quotes][0]
      [response[:quote], response[:author]]
    end

    private

    def rate_limited?(response)
      response.response.code == "429"
    end

    def parse_contents(qod_response)
      json_object = JSON.parse(qod_response.to_s, :symbolize_names => true)
      json_object[:contents]
    end
  end

end
