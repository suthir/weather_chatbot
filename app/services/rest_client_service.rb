
class RestClientService
  BASE_URL = "https://platform.openai.com".freeze

  def initialize(base_url = BASE_URL)
    @base_url = base_url
  end

  def get(endpoint, headers = {})
    request(Net::HTTP::Get.new(build_uri(endpoint), headers))
  end

  def post(endpoint, body = {}, headers = {})
    request_with_body(Net::HTTP::Post.new(build_uri(endpoint), headers), body)
  end

  def put(endpoint, body = {}, headers = {})
    request_with_body(Net::HTTP::Put.new(build_uri(endpoint), headers), body)
  end

  def patch(endpoint, body = {}, headers = {})
    request_with_body(Net::HTTP::Patch.new(build_uri(endpoint), headers), body)
  end

  def delete(endpoint, headers = {})
    request(Net::HTTP::Delete.new(build_uri(endpoint), headers))
  end

  private

  def build_uri(endpoint)
    URI.join(@base_url, endpoint)
  end

  def request(http_request)
    http = Net::HTTP.new(http_request.uri.host, http_request.uri.port)
    http.use_ssl = true if http_request.uri.scheme == "https"
    response = http.request(http_request)
    parse_response(response)
  end

  def request_with_body(http_request, body)
    http_request.content_type = "application/json"
    http_request.body = body.to_json unless body.empty?
    request(http_request)
  end

  def parse_response(response)
    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      { error: response.message, code: response.code }
    end
  end
end
