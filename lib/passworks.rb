require 'passworks/version'
require 'passworks/configuration'
require 'passworks/client'

module Passworks
  extend Configuration

    def self.new(options={})
      merged_options = self.options.merge(options)
      @client = Client.new(merged_options) unless defined?(@client) && @client.same_options?(merged_options)
      @client
    end

    def self.respond_to?(method, include_all=false)
      new.respond_to?(method, include_all) || super
    end

    def self.method_missing?(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

end