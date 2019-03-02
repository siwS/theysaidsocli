require_relative "theysaidsocli/version"
require "httparty"

module Theysaidsocli
  class Error < StandardError; end

  class QuoteFetcher

    QOD_URL = "http://quotes.rest/qod.json"
    RANDOM_QUOTE_URL = "http://quotes.rest/quote/random.json"

    def random
      puts "a random quote"
    end

    def qod
      qod_response = HTTParty.get(QOD_URL)
      if qod_response.response.code == "429"
        return "You asked for too many quotes... Try again in an hour"
      end

      parse_quote(qod_response)
    end

    private

    def parse_quote(qod_response)
      json_object = JSON.parse(qod_response.to_s, :symbolize_names => true)
      json_object[:contents][:quotes][0][:quote]
    end


  end

  QuoteFetcher.new.qod
end
