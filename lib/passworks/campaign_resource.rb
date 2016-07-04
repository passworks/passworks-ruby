require 'passworks/resource'

module Passworks

  # Represents a Campaign of a given type: Coupon, Boarding Pass, Event Ticket, Generic, Store Card
  #
  class CampaignResource < Resource

    # @return [RequestProxy]
    def passes(options={})
      Passworks::RequestProxy.new(client, collection_name, id, options)
    end

    def daily_report(options={})
      options = options.select {|k,v| ['start_date', 'end_date'].include?(k.to_s) }
      options = options.collect{|k,v| "#{k}=#{v}"}.join('&')
      client.get("#{collection_name}/#{id}/reports?#{options}").data
    end

    def total_report
      client.get("#{collection_name}/#{id}/reports/totals").data
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

    # Merges all campaign data changes into the passes using the PassUpdater
    # /lib/ in the main backend-saas project.
    # @return [Boolean]
    def merge
      client.post("#{collection_name}/#{id}/merge").ok?
    end

    # Updates the {CampaignResource} and returns the updated instance
    # @return [CampaignResource] Updated instance
    def update(data, params={})
      content = {
        body: {
          single_name.to_sym => data
        }.merge(params)
      }
      response  = client.patch("#{collection_name}/#{id}", content)
      self.class.new(client, collection_name, response.data)
    end
  end
end
