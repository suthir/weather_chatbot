class WeatherService
  ENDPOINT = "https://api.openweathermap.org".freeze
  WEATHER_ROUTE = "data/2.5/weather?q=%{query}&units=%{unit}&appid=%{api_key}".freeze

  def initialize(endpoint = ENDPOINT)
    @endpoint = endpoint
    @client = RestClientService.new(@endpoint)
    @api_key = ENV["WEATHER_API_KEY"]
    @units = "metric"
  end

  def get_weather(query)
    @client.get(WEATHER_ROUTE % { query: query, unit: @units, api_key: @api_key })
  end
end
