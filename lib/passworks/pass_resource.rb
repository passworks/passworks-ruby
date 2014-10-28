require 'passworks/resource'

module Passworks
  class PassResource < Resource

    def delete
      client.delete("#{collection_name}/#{collection_uuid}/passes/#{id}").ok?
    end

    def push
      client.post("#{collection_name}/#{collection_uuid}/passes/#{id}/push").ok?
    end

    private
      def collection_uuid
        @collection_uuid ||= send("#{single_name}_id")
      end

  end
end