require 'passworks/resource'

module Passworks

  # Represents a Campaign of a given type: Coupon, Boarding Pass, Event Ticket, Generic, Store Card
  #
  class CampaignResource < Resource

    # @return [RequestProxy]
    def passes(options={})
      Passworks::RequestProxy.new(client, collection_name, id, options)
    end

    # Deletes the current Campaign
    # @return [Boolean]
    def delete
      client.delete("#{collection_name}/#{id}").ok?
    end

    # Send push notifications to all customers that have installed passes from this campaign
    # @return [Boolean]
    def push
      client.post("#{collection_name}/#{id}/push").ok?
    end

  end
end