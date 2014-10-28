require 'passworks/resource'

module Passworks
  class CampaignResource < Resource

    def passes(options={})
      Passworks::RequestProxy.new(client, collection_name, id, options)
    end

    def delete
      client.delete("#{collection_name}/#{id}").ok?
    end

    def push
      client.post("#{collection_name}/#{id}/push").ok?
    end

  end
end