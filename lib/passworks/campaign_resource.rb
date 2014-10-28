require 'passworks/resource'

module Passworks
  class CampaignResource < Resource

    def passes(options={})
      Passworks::RequestProxy.new(client, collection_name, id, options)
    end

    def delete
    end

    def push
    end

  end
end