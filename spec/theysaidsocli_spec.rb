require "httparty"

RSpec.describe Theysaidsocli do

  let(:qod) { "The things you learn in maturity aren’t simple things such as acquiring information and skills. You learn not to engage in self-destructive behavior. You learn not to burn up energy in anxiety. You discover how to manage your tensions. You learn that self-pity and resentment are among the most toxic of drugs. You find that the world loves talent but pays off on character." }

  let(:response_body) {  double("Response", code: code) }
  let(:http_party_response) { instance_double("HTTParty::Response", response: response_body, to_s: qod_response)}

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

  it "has a version number" do
    expect(Theysaidsocli::VERSION).not_to be nil
  end

  context "with successful return" do
    let(:code) { "200" }

    it "prints the quote of the day" do
      expect(HTTParty).to receive(:get).with(Theysaidsocli::QuoteFetcher::QOD_URL).and_return(http_party_response)
      ct = Theysaidsocli::QuoteFetcher.new
      expect(ct.qod).to eq(qod)
    end
  end

  context "with rate limit" do
    let(:code) { "429" }

    it "with rate limit it returns appropriate error" do
      expect(HTTParty).to receive(:get).with(Theysaidsocli::QuoteFetcher::QOD_URL).and_return(http_party_response)
      ct = Theysaidsocli::QuoteFetcher.new
      expect(ct.qod).to eq("You asked for too many quotes... Try again in an hour")
    end
  end


end

