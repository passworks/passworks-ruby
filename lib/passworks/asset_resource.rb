module Passworks
  class AssetResource < Resource

    # Deletes the current Asset
    # @return [Boolean]
    def delete
      client.delete("#{collection_name}/#{id}").ok?
    end
    alias_method :destroy, :delete

  end
end