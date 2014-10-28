module Passworks
  module Inflector

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