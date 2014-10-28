require 'passworks/version'

module Passworks
  module Configuration

    VALID_CONNECTION_KEYS = [:endpoint, :user_agent].freeze

    VALID_OPTION_KEYS     = [:api_username, :api_secret, :debug].freeze

    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTION_KEYS

    DEFAULT_ENDPOINT      = 'https://api.passworks.io'

    DEFAULT_USER_AGENT    = "Passworks Ruby API Client/#{Passworks::VERSION} Ruby/#{RUBY_VERSION} Platform/#{RUBY_PLATFORM}"

    attr_accessor *VALID_CONFIG_KEYS

    def configure
      yield self
    end

    def reset!
      Configuration.default_options.each do |key, value|
        self.instance_variable_set(:"@#{key}", value)
      end
    end

    def options
      Configuration.default_options.keys.inject({}) do |hash, key|
        hash[key] = self.instance_variable_get(:"@#{key}")
        hash
      end
    end

    def self.default_options
      @default_options ||= {
        endpoint:     ENV['PASSWORKS_ENDPOINT']     || DEFAULT_ENDPOINT   ,
        user_agent:   ENV['PASSWORKS_USER_AGENT']   || DEFAULT_USER_AGENT ,
        api_username: ENV['PASSWORKS_API_USERNAME']                       ,
        api_secret:   ENV['PASSWORKS_API_SECRET']                         ,
        debug:        false
      }
    end

    def endpoint
      File.join(@endpoint, 'v1').to_s
    end

    class << self
      def extended(base)
        base.reset!
      end
    end

  end
end