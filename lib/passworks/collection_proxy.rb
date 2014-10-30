require 'passworks/inflector'

module Passworks
  class CollectionProxy

    include Enumerable
    include Passworks::Inflector

    attr_reader :collection_name, :collection_uuid, :client, :options

    def initialize(client, collection_name, collection_uuid=nil, options={})
      @collection_name  = collection_name
      @collection_uuid  = collection_uuid
      @client           = client
      @options          = options
    end

    def each(&block)
      next_page = nil
      loop do
        if next_page
          response = client.get(collection_url, options.merge({query: {page: next_page}}))
        else
          response = client.get(collection_url, options)
        end
        response.data.each do |item_data|
          yield resource_class.new(client, collection_name, item_data)
        end
        next_page = response.next_page
        break if next_page.nil?
      end
      self
    end

    private

      def collection_url
        if collection_uuid
          "#{collection_name}/#{collection_uuid}/passes"
        else
          collection_name
        end
      end

  end
end