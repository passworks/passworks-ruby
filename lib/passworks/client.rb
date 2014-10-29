require 'passworks/configuration'
require 'passworks/request'
require 'passworks/request_proxy'


module Passworks

  # Client is the HTTP API Wrapper to comunicate with the Passworks API
  #
  class Client

    include Passworks::Configuration
    include Passworks::Request

    def initialize(params={})
      Configuration::VALID_CONFIG_KEYS.each do |key|
        self.instance_variable_set(:"@#{key}", params[key])
      end
    end

    # Check if the current {Client} instance options are equal to the passed ones
    # @param options [Hash] options
    # @return [Boolean]
    def same_options?(options)
      self.options == options
    end

    # @!method assets
    #   Allows to to access the Assets API
    #   @return [Passworks::RequestProxy]
    # @!method boarding_passes
    #   Allows to to access the Boarding Pass API
    #   @return [Passworks::RequestProxy]
    # @!method store_cards
    #   Allows to to access the Store Cards API
    #   @return [Passworks::RequestProxy]
    # @!method coupons
    #   Allows to to access the Coupons API
    #   @return [Passworks::RequestProxy]
    # @!method generics
    #   Allows to to access the Generic API
    #   @return [Passworks::RequestProxy]

    %w(assets boarding_passes store_cards coupons generics).each do |collection_name|
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