require_relative "theysaidso/version"
require_relative "quote"
require_relative "response"
require_relative "category"
require "httparty"

class RateLimitError < StandardError; end
class NotFoundError < StandardError; end

class QuoteFetcher

  QOD_URL = "http://quotes.rest/qod.json"
  QOD_URL_WITH_CATEGORY = "http://quotes.rest/qod.json?category="
  CATEGORIES_URL = "http://quotes.rest/qod/categories.json"

  def categories
    categories_response = HTTParty.get(CATEGORIES_URL)

    response = Response.new(categories_response)
    raise RateLimitError if response.rate_limited?
    raise NotFoundError unless response.success?

    categories = []
    response.content[:categories].each do |key, value|
      categories << Category.new(key, value)
    end
    categories
  end

  def qod(category = nil)
    qod_response = HTTParty.get(category ? "#{QOD_URL_WITH_CATEGORY}#{category}" : QOD_URL)

    response = Response.new(qod_response)
    raise RateLimitError if response.rate_limited?
    raise NotFoundError unless response.success?

    Quote.new(response.content[:quotes][0])
  end
end
