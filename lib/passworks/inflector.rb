module Passworks
  module Inflector

    # Return the singular version of the *curren_collection* name
    # @return [String] singular version of the current collection name
    def single_name
      case collection_name
      when 'assets'
        'asset'
      when 'certificates'
        'certificate'
      when 'boarding_passes'
        'boarding_pass'
      when 'coupons'
        'coupon'
      when 'store_cards'
        'store_card'
      when 'event_tickets'
        'event_ticket'
      when 'generics'
        'generic'
      else
        raise 'Invalid Collection Name'
      end
    end

    # Return resource class based in collection_name and collection_uuid
    # If collection_name  return [Passworks::AssetResource]
    # If  collection_uuid == nil return [Passworks::CampaignResource] else return [Passworks::PassResource]
    def resource_class
      return Passworks::AssetResource       if collection_name == 'assets'
      # CertificateResource has no overrides, but follow along the normal flow.
      return Passworks::CertificateResource if collection_name == 'certificates'
      if collection_uuid
        Passworks::PassResource
      else
        Passworks::CampaignResource
      end
    end

  end
end