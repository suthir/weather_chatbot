# Weather ChatBot 1.0

A simple ChatBot application that interacts with humans for real-time weather-related queries.

This application is designed to provide real-time updates for weather-related questions and offers seamless interaction between humans and AI.

The platform is integrated with LangSmith to enable LLM-powered application lifecycle monitoring.

This application can easily auto-scale in production environments to support enterprise-level usage.

## Instructions

Follow the instructions below to set up the developer environment for Weather ChatBot application.

*These steps have been tested on Mac environments.*

1. **Install Developer Tools**

   Use the Xcode Command Line Tools to install development tools. This is recommended for installing native extensions when installing gems.

   _Please ignore this step if you are not using Mac_

   ```bash
   xcode-select --install
    ```
2. **Install rbenv**

   If your system already has Ruby 3.3.4, you can skip step-2, step-3, and step-4.

   ```bash
   brew install rbenv
    ```
3. **Install Ruby 3.3.6**

   ```bash
   rbenv install 3.3.6
    ```
4. **Install Redis**

   ```bash
   brew install redis
    ```
    This will install Redis on your system
5. **Start Redis Server in the foreground**
    
   ```bash
   redis-server
    ```
6. **Set up Bundler and System Gems**

   ```bash
   gem install bundler
    ```
7. **Clone the Weather ChatBot Repository**

   ```bash
   git clone git@github.com:suthir/weather_chatbot.git -b main
    ```
8. **Install Package Dependencies**

   ```bash
   cd weather_chatbot && bundle install
    ```
9. **Create the Database**

   ```bash
   rails db:create
    ```
10. **Install Database Schemas**

    ```bash
    rails db:migrate
    ```
11. **Set Environment Variables**

    *Update the environment variables with your LangChain API key, project name, and Weather API key.*

    LangChain API key and project name can be obtained from [LangSmith](https://smith.langchain.com/).

    The Weather API key can be obtained from [OpenWeatherMap](https://home.openweathermap.org/users/sign_in).

    ```bash
    export LANGCHAIN_API_KEY="your_api_key"
    export LANGCHAIN_PROJECT="your_project_name"
    export WEATHER_API_KEY="your_weather_api_key"
    ```
12. **Run the ChatBot app in local**
    ```bash
    bin/dev
    ```

13. **Open WeatherChatBot through web-browser**

    *ChatBot app will be running in port 3000 by default.*
    ```bash
    http://localhost:3000
    ```


