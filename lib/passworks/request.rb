require 'uri'
require 'faraday'
require 'faraday_middleware'
require 'passworks/faraday/http_exception_middleware'
require 'passworks/response'


module Passworks
  module Request


    def request(method, path, options={})
      response = agent.send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options[:query])
        when :post, :put, :patch
          request.path = path
          request.body = options.fetch(:body, {})
        end
      end
      Response.new(self, response)
    end

    def agent
      @agent ||= ::Faraday.new(endpoint) do |connection|
        connection.basic_auth(@api_username, @api_secret)
        connection.request :multipart
        connection.request :json
        connection.response :logger
        connection.response :json, :content_type => /\bjson$/
        connection.use Passworks::Faraday::HttpExceptionMiddleware
        connection.adapter ::Faraday.default_adapter
      end
      @agent.headers[:user_agent] = @user_agent
      # always return the {@agent}
      @agent
    end

    def get(url, options={})
      request(:get, url, options)
    end

    def post(url, options={})
      request(:post, url, options)
    end

    def patch(url, options={})
      request(:patch, url, options)
    end

    def delete(url, options={})
      request(:delete, url, options)
    end

  end
end