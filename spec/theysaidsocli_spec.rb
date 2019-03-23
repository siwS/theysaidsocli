require "httparty"
require_relative "../lib/theysaidsocli"

RSpec.describe QuoteFetcher do

  let(:quote_fetcher) { QuoteFetcher.new }
  let(:qod) { "The things you learn in maturity aren’t simple things such as acquiring information and skills. You learn not to engage in self-destructive behavior. You learn not to burn up energy in anxiety. You discover how to manage your tensions. You learn that self-pity and resentment are among the most toxic of drugs. You find that the world loves talent but pays off on character." }

  let(:response_body) {  double("Response", code: code) }
  let(:http_party_response) { instance_double("HTTParty::Response", response: response_body, to_s: string_response.to_json)}

  let(:author) { "John Gardner" }
  let(:length) { "381" }
  let(:tags) { %w[ character, inspire, maturity ] }
  let(:qod_category) { "inspire" }
  let(:qod_category_with_invalid_chars) { "l/i.f>e<!" }

  let(:date) { "2019-03-02" }

  let(:qod_response) do
    {
        'success': {
            'total': 1
        },
        'contents': {
            'quotes': [
                {
                    'quote': qod,
                    'author': author,
                    'length': length,
                    'tags': tags,
                    'category': qod_category,
                    'title': 'Inspiring Quote of the day',
                    'date': date,
                    'id': '1'
                }
            ],
            'copyright': '2017-19 theysaidsocli.com'
        }
    }
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

  let(:categories_response) do
    {
        "success": {
            "total": 8
        },
        "contents": {
            "categories": categories_hash,
            "copyright": "2017-19 http://theysaidsocli.com"
        }
    }
  end

  it "has a version number" do
    expect(Theysaidso::VERSION).not_to be nil
  end

  context "with qod successful response" do
    let(:code) { "200" }
    let(:string_response) { qod_response }
    let(:category) { "life" }

    it "prints the quote of the day" do
      expect(HTTParty).to receive(:get).with(QuoteFetcher::QOD_URL).and_return(http_party_response)
      quote = quote_fetcher.qod
      expect(quote.quote).to eq(qod)
      expect(quote.author).to eq(author)
      expect(quote.category).to eq(qod_category)
      expect(quote.date).to eq(date)
      expect(quote.tags).to eq(tags)
      expect(quote.length).to eq(length)
    end

    it "prints the qod for a given category" do
      expect(HTTParty).to receive(:get).with(QuoteFetcher::QOD_URL+"?category=#{category}").and_return(http_party_response)
      quote = quote_fetcher.qod(category)
      expect(quote.quote).to eq(qod)
      expect(quote.author).to eq(author)
      expect(quote.category).to eq(qod_category)
      expect(quote.date).to eq(date)
      expect(quote.tags).to eq(tags)
      expect(quote.length).to eq(length)
    end

    it "cleans up the string if contains special characters" do
      expect(HTTParty).to receive(:get).with(QuoteFetcher::QOD_URL+"?category=#{category}").and_return(http_party_response)
      quote_fetcher.qod(qod_category_with_invalid_chars)
    end
  end

  context "with qod rate limit" do
    let(:code) { "429" }
    let(:string_response) { qod_response }
    let(:category) { "life" }

    it "with rate limit it raises appropriate error" do
      expect(HTTParty).to receive(:get).with(QuoteFetcher::QOD_URL).and_return(http_party_response)
      expect{ quote_fetcher.qod }.to raise_error(RateLimitError)
    end

    it "with rate limit it raises appropriate error" do
      expect(HTTParty).to receive(:get).with(QuoteFetcher::QOD_URL+"?category=#{category}").and_return(http_party_response)
      expect{ quote_fetcher.qod(category) }.to raise_error(RateLimitError)
    end
  end

  context "with categories successful response" do
    let(:code) { "200" }
    let(:string_response) { categories_response }

    it "returns the category hash" do
      expect(HTTParty).to receive(:get).with(QuoteFetcher::CATEGORIES_URL).and_return(http_party_response)
      categories = quote_fetcher.categories
      expect(categories.size).to eq(8)
      categories.each do |category|
        expect(category.description).to eq(categories_hash[category.key])
      end
    end
  end

  context "with qod rate limit" do
    let(:code) { "429" }
    let(:string_response) { categories_response }

    it "with rate limit it raises appropriate error" do
      expect(HTTParty).to receive(:get).with(QuoteFetcher::QOD_URL).and_return(http_party_response)
      expect{ quote_fetcher.qod }.to raise_error(RateLimitError)
    end
  end
end

