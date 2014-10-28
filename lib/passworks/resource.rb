require 'passworks/inflector'
require 'ostruct'

module Passworks
  class Resource < OpenStruct

    include Passworks::Inflector

    attr_reader :collection_name, :client

    def initialize(client, collection_name, data)
      @client          = client
      @collection_name = collection_name
      super(data)
    end

  end
end