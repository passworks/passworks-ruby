module Passworks
  module Inflector

    # Return the singular version of the *curren_collection* name
    # @return [String] singular version of the current collection name
    def single_name
      case collection_name
      when 'assets'
        'asset'
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

  end
end