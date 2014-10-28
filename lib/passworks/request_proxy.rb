require 'passworks/collection_proxy'
require 'passworks/inflector'
require 'passworks/exceptions/file_not_found'

module Passworks
  class RequestProxy

    include Passworks::Inflector

    attr_reader :client, :collection_name, :collection_uuid

    def initialize(client, collection_name, collection_uuid=nil, options={})
      @collection_name = collection_name
      @collection_uuid = collection_uuid
      @client          = client
      @options         = options
    end

    def all(options={})
      options = { query: options } unless options.empty?
      CollectionProxy.new(client, collection_name, collection_uuid, options)
    end

    def find(uuid)
      if collection_uuid
        response = client.get("#{collection_name}/#{collection_uuid}/passes/#{uuid}")
        PassResource.new(client, collection_name, response.data)
      else
        response = client.get("#{collection_name}/#{uuid}")
        CampaignResource.new(client, collection_name, response.data)
      end
    end

    def create(campaing_or_pass_data={}, extra_args={})

      if collection_name.to_s == 'assets' && collection_uuid.nil?
        raise Passworks::Exceptions::FileNotFound.new("Can't find file #{hash[:file]}") unless hash.has_key?(:file) && File.exists?(hash[:file])
        hash[:file] = ::Faraday::UploadIO.new(hash[:file], "image/#{hash[:file].split('.').last.downcase}")
      end

      if collection_uuid
        content = {
          body: {
            'pass' => campaing_or_pass_data
          }.merge(extra_args)
        }
        response = client.post("#{collection_url}/passes", content)
        PassResource.new(client, collection_name, response.data)
      else
        content = {
          body: {
            single_name.to_sym => campaing_or_pass_data
          }.merge(extra_args)
        }
        response = client.post(collection_url, content)
        CampaignResource.new(client, collection_name, response.data)
      end

    end

    def delete(uuid)
      if collection_uuid
        client.delete("#{collection_name}/#{collection_uuid}/passes/#{uuid}").ok?
      else
        client.delete("#{collection_name}/#{uuid}").ok?
      end
    end


    def collection_url
      if collection_uuid
        "#{collection_name}/#{collection_uuid}"
      else
        collection_name
      end
    end

  end
end