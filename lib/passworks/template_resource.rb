module Passworks
  class TemplateResource < Resource

    # Deletes the current Template
    # @return [Boolean]
    def delete(delete_assets = true)
      content = {
        body: {
          single_name.to_sym => {
            delete_assets: delete_assets
          }
        }
      }
      response  = client.delete("#{collection_name}/#{id}", content)
    end
    alias_method :destroy, :delete

  end
end