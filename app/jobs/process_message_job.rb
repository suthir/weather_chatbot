class ProcessMessageJob < ApplicationJob
  include ApplicationHelper
  queue_as :default

  def perform(id)
    logger.info "Agent Received [#{id}]"
    message = ChatMessage.find(id)
    logger.info "Prompt [#{message.prompt}]"

    @langsmith = LangSmithService.new
    @langsmith.trace(prompt: message.prompt)

    city_name = find_city(message.prompt)
    logger.info "[#{city_name}] found from the prompt"

    @weather = WeatherService.new
    response = @weather.get_weather(city_name)

    if response[:error].nil?
      logger.info "Weather has been successfully retrived from openweather"
      prompt_response = "The weather in #{city_name} is #{response['weather'][0]['description']} with a temperature of #{response['main']['temp']}°C."
      puts "***** #{prompt_response}"
      message.update!(response: prompt_response)
      @langsmith.trace(prompt: message.prompt, context: prompt_response, outputs: prompt_response)
    else
      logger.error "Error found while retriving weather from openweather"
      response = "Unable to get weather details"
      message.update!(response: response)
      @langsmith.trace(prompt: message.prompt, context: response, outputs: response)
    end
    logger.info "Agent has been successfully processed the prompt"
  end
end
