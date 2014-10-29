require 'passworks/resource'

module Passworks

  # Represents a Pass of a given collection type Coupon, Boarding Pass, Event Ticket, Generic, Store Card
  #
  class PassResource < Resource

    # Deletes the current pass
    # @return [Boolean] True in case the pass is deleted
    def delete
      client.delete("#{collection_name}/#{collection_uuid}/passes/#{id}").ok?
    end

    # Sends a push notification to all clients with this pass installed
    # @return [Boolean] True in case the pass
    def push
      client.post("#{collection_name}/#{collection_uuid}/passes/#{id}/push").ok?
    end

    private
      def collection_uuid
        @collection_uuid ||= send("#{single_name}_id")
      end

  end

end