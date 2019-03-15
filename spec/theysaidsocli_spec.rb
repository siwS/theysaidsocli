require "httparty"

RSpec.describe Theysaidsocli do

  let(:quote_fetcher) { Theysaidsocli::QuoteFetcher.new }
  let(:qod) { "The things you learn in maturity aren’t simple things such as acquiring information and skills. You learn not to engage in self-destructive behavior. You learn not to burn up energy in anxiety. You discover how to manage your tensions. You learn that self-pity and resentment are among the most toxic of drugs. You find that the world loves talent but pays off on character." }

  let(:response_body) {  double("Response", code: code) }
  let(:http_party_response) { instance_double("HTTParty::Response", response: response_body, to_s: string_response)}

  let(:qod_response) do
    '{
        "success": {
            "total": 1
        },
        "contents": {
            "quotes": [
                {
                    "quote": "The things you learn in maturity aren’t simple things such as acquiring information and skills. You learn not to engage in self-destructive behavior. You learn not to burn up energy in anxiety. You discover how to manage your tensions. You learn that self-pity and resentment are among the most toxic of drugs. You find that the world loves talent but pays off on character.",
                    "author": "John Gardner",
                    "length": "381",
                    "tags": [
                        "character",
                        "inspire",
                        "maturity",
                        "tso-life",
                        "tso-management"
                    ],
                    "category": "inspire",
                    "title": "Inspiring Quote of the day",
                    "date": "2019-03-02",
                    "id": "1"
                }
            ],
            "copyright": "2017-19 theysaidso.com"
        }
    }'
  end

  let(:categories_hash) do
    {
        "inspire": "Inspiring Quote of the day",
        "management": "Management Quote of the day",
        "sports": "Sports Quote of the day",
        "life": "Quote of the day about life",
        "funny": "Funny Quote of the day",
        "love": "Quote of the day about Love",
        "art": "Art quote of the day ",
        "students": "Quote of the day for students"
    }
  end

  let(:author) { "John Gardner" }

  let(:categories_response) do
    '{
        "success": {
            "total": 8
        },
        "contents": {
            "categories": {
                "inspire": "Inspiring Quote of the day",
                "management": "Management Quote of the day",
                "sports": "Sports Quote of the day",
                "life": "Quote of the day about life",
                "funny": "Funny Quote of the day",
                "love": "Quote of the day about Love",
                "art": "Art quote of the day ",
                "students": "Quote of the day for students"
            },
            "copyright": "2017-19 http://theysaidso.com"
        }
    }'
  end

  it "has a version number" do
    expect(Theysaidsocli::VERSION).not_to be nil
  end

  context "with qod successful response" do
    let(:code) { "200" }
    let(:string_response) { qod_response }
    let(:category) { "life" }

    it "prints the quote of the day" do
      expect(HTTParty).to receive(:get).with(Theysaidsocli::QuoteFetcher::QOD_URL).and_return(http_party_response)
      expect(quote_fetcher.qod).to eq([qod, author])
    end

    it "prints the qod for a given category" do
      expect(HTTParty).to receive(:get).with(Theysaidsocli::QuoteFetcher::QOD_URL+"?category=#{category}").and_return(http_party_response)
      expect(quote_fetcher.qod(category)).to eq([qod, author])
    end
  end

  context "with qod rate limit" do
    let(:code) { "429" }
    let(:string_response) { qod_response }
    let(:category) { "life" }

    it "with rate limit it raises appropriate error" do
      expect(HTTParty).to receive(:get).with(Theysaidsocli::QuoteFetcher::QOD_URL).and_return(http_party_response)
      expect{ quote_fetcher.qod }.to raise_error(Theysaidsocli::RateLimitError)
    end

    it "with rate limit it raises appropriate error" do
      expect(HTTParty).to receive(:get).with(Theysaidsocli::QuoteFetcher::QOD_URL+"?category=#{category}").and_return(http_party_response)
      expect{ quote_fetcher.qod(category) }.to raise_error(Theysaidsocli::RateLimitError)
    end
  end

  context "with categories successful response" do
    let(:code) { "200" }
    let(:string_response) { categories_response }

    it "returns the category hash" do
      expect(HTTParty).to receive(:get).with(Theysaidsocli::QuoteFetcher::CATEGORIES_URL).and_return(http_party_response)
      expect(quote_fetcher.categories).to eq(categories_hash)
    end
  end

  context "with qod rate limit" do
    let(:code) { "429" }
    let(:string_response) { categories_response }

    it "with rate limit it raises appropriate error" do
      expect(HTTParty).to receive(:get).with(Theysaidsocli::QuoteFetcher::QOD_URL).and_return(http_party_response)
      expect{ quote_fetcher.qod }.to raise_error(Theysaidsocli::RateLimitError)
    end
  end
end

