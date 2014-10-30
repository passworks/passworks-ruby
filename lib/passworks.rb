require 'uri'
require 'faraday'
require 'faraday_middleware'
require 'passworks/version'
require 'passworks/configuration'
require 'passworks/exception'
require 'passworks/response'
require 'passworks/inflector'
require 'passworks/faraday/http_exception_middleware'
require 'passworks/request'
require 'passworks/request_proxy'
require 'passworks/client'
require 'passworks/collection_proxy'
require 'passworks/resource'
require 'passworks/campaign_resource'
require 'passworks/asset_resource'
require 'passworks/pass_resource'

# Passworks

module Passworks
  extend Configuration

    # Creates an instance of {Passworks::Client} to allow access to Passworks API
    # @param [Hash] options
    # @option options [String] :endpoint Defines the API end point (see {Passworks::Configuration::DEFAULT_ENDPOINT} for default endpoint)
    # @option options [String] :api_username Your API username
    # @option options [String] :api_secret Your API secret key
    # @option options [Boolean] :debug Enables debug messages to STDOUT
    #
    # @return [Passworks::Client]
    def self.new(options={})
      merged_options = self.options.merge(options)
      @client = Client.new(merged_options) unless defined?(@client) && @client.same_options?(merged_options)
      @client
    end

    # @!visibility private
    def self.respond_to?(method, include_all=false)
      new.respond_to?(method, include_all) || super
    end

    # @!visibility private
    def self.method_missing?(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

end
