class LangSmithService
  LANGCHAIN_ENDPOINT = "https://api.smith.langchain.com".freeze
  LANGCHAIN_TRACING_V2 = "true".freeze
  OPENAI_API_KEY = ENV["OPENAI_API_KEY"]

  def initialize(endpoint = LangSmithService::LANGCHAIN_ENDPOINT, api_key = ENV["LANGCHAIN_API_KEY"], project = ENV["LANGCHAIN_PROJECT"] || "default")
    @endpoint = endpoint
    @api_key = api_key
    @project = project
    @headers = { "x-api-key": "#{@api_key}" }
    @client = RestClientService.new(@endpoint)
    @parent_run_id = nil
  end

  def create_runs(run_id, name, run_type, inputs, parent_id = nil)
    data = {
        id: run_id,
        name: name,
        run_type: run_type,
        inputs: inputs,
        start_time: Time.now.utc,
        session_name: @project
    }
    data[:parent_run_id] = parent_id if parent_id
    @client.post("/runs", data, @headers)
  end

  def update_runs(run_id, outputs)
    outputs = {
      outputs: outputs,
      end_time: Time.now.utc
    }
    @client.patch("/runs/#{run_id}", outputs, @headers)
  end

  def trace(prompt: nil, context: nil, outputs: nil)
    if @parent_run_id.nil?

      @parent_run_id = SecureRandom.uuid_v4

      inputs = {
        question: prompt
      }
      create_runs(@parent_run_id, "WeatherChatBot", "chain", inputs)

    else

      messages = [
        {
          role: "system",
          content: "You are a helpful assistant. Please respond to the user's request only based on the given context."
        },
        {
          role: "user",
          content: "Question: #{prompt}\nContext: #{context}"
        }
      ]

      child_run_id = SecureRandom.uuid_v4
      inputs = {
        messages: messages
      }
      create_runs(child_run_id, "WeatherChatBot", "llm", inputs, @parent_run_id)
    end

    if !outputs.nil?
      outputs = {
        answer: outputs
      }
      update_runs(child_run_id, outputs)
      update_runs(@parent_run_id, outputs)
    end
  end
end
