require 'passworks/configuration'
require 'passworks/request'
require 'passworks/request_proxy'


module Passworks
  class Client
    include Passworks::Configuration
    include Passworks::Request

    def initialize(params={})
      Configuration::VALID_CONFIG_KEYS.each do |key|
        self.instance_variable_set(:"@#{key}", params[key])
      end
    end

    def same_options?(options)
      self.options == options
    end

    %w(assets bording_passes store_cards coupons generics).each do |collection_name|
      define_method(collection_name) do
        Passworks::RequestProxy.new(self, collection_name, nil)
      end
    end

    def inspect
      inspected = super
      inspected.gsub!(/\@api_secret=(.+)/){ "@api_secret=\"**********\"" }
      inspected
    end

  end
end