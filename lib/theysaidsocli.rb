require_relative "theysaidsocli/version"
require_relative "quote"
require "httparty"

module Theysaidsocli

  class RateLimitError < StandardError; end
  class NotFoundError < StandardError; end

  class QuoteFetcher

    QOD_URL = "http://quotes.rest/qod.json"
    QOD_URL_WITH_CATEGORY = "http://quotes.rest/qod.json?category="
    CATEGORIES_URL = "http://quotes.rest/qod/categories.json"

    def categories
      categories_response = HTTParty.get(CATEGORIES_URL)
      raise RateLimitError if rate_limited?(categories_response)

      parse_contents(categories_response)[:categories]
    end

    def qod(category = nil)
      qod_response = HTTParty.get(category ? "#{QOD_URL_WITH_CATEGORY}#{category}" : QOD_URL)
      raise RateLimitError if rate_limited?(qod_response)

      response = parse_contents(qod_response)

      raise NotFoundError if response.nil?

      Quote.new(response[:quotes][0])
    end

    private

    def rate_limited?(response)
      response.response.code == "429"
    end

    def parse_contents(qod_response)
      stringify_response = qod_response.to_s
      json_object = JSON.parse(stringify_response, :symbolize_names => true)
      json_object[:contents]
    end
  end

end
