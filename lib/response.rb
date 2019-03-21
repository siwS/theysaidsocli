class Response

  attr_accessor :content

  def initialize(http_response)
    @status = http_response.response.code
    @content = parse_contents(http_response)
  end

  def rate_limited?
    @status == "429"
  end

  def success?
    @status == "200" && !@content.nil?
  end

  private

  def parse_contents(response)
    stringify_response = response.to_s
    json_object = JSON.parse(stringify_response, :symbolize_names => true)
    json_object[:contents]
  end

end