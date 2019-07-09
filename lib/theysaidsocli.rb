require_relative "theysaidsocli/version"
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

    categories.content[:categories].map { |k, v| Category.new(k, v) }
  end

  def qod(category = nil)
    sanitized_category = sanitize_input(category)
    qod_response = HTTParty.get(sanitized_category ? "#{QOD_URL_WITH_CATEGORY}#{sanitized_category}" : QOD_URL)

    response = Response.new(qod_response)
    raise RateLimitError if response.rate_limited?
    raise NotFoundError unless response.success?

    Quote.new(response.content[:quotes][0])
  end

  private

  def sanitize_input(category)
    return nil if category.nil?
    category.gsub(/[^0-9A-Za-z]/,'')
  end

end
