# passworks-ruby [![Code Climate](https://codeclimate.com/github/passworks/passworks-ruby/badges/gpa.svg)](https://codeclimate.com/github/passworks/passworks-ruby) [![Build Status](https://travis-ci.org/passworks/passworks-ruby.svg)](https://travis-ci.org/passworks/passworks-ruby)

Ruby bindings for the Passworks API (http://api.passworks.io)

[API Documentation](https://github.com/passworks/passworks-api)

Passworks Ruby API client can be installed via rubygems [http://rubygems.org/gems/passworks](http://rubygems.org/gems/passworks).


## Instalation


```ruby
gem install passworks
```

Using bundler

```ruby
gem 'passworks'
```

## Basic usage

### Configuring the client


The Passworks ruby client can be configured at class level or instance level.

```ruby
# Class level configuration
Passworks.configure do |config|
  config.api_username = "your api username"
  config.api_secret   = "your api secret"
end

client = Passworks.new
```

```ruby
# Instance level configuration
client = Passworks.new({
  api_username: 'your api username',
  api_secret: 'your api secret'
})
```

## Examples

### Certificates

Certificates are an essential part of every campaign.

They're used to uniquely identify a certain person or organization, and offer authenthicity reasurance. [See Passworks API](https://github.com/passworks/passworks-api/blob/master/v2/sections/certificates.md#certificates) for mode information.

```ruby
# Fetch and iterate through all your certificates
certificates = client.certificates.all
certificates.each do |certificate|
  puts certificate
end

# Fetch a specific certificate via uuid (uuid=c3d5fc64-3a43-4d3a-a167-473dfeb1edd3)
certificate = client.certificates.find('c3d5fc64-3a43-4d3a-a167-473dfeb1edd3')
```

### Assets

Assets are the visual elements of the pass.

You can reuse assets, meaning that you can assign the same asset to multiple passes, reducing the number of asset operations and also reducing the amount of bandwidth required to create a pass. [See Passworks API](https://github.com/passworks/passworks-api/blob/master/v2/sections/assets.md#assets) for mode information.

```ruby
# Upload an asset (icon image)
asset_icon = client.assets.create({ file: '/path-to-file/icon-file.png', asset_type: 'icon' })

# Fetch and iterate through all your assets
assets = client.assets.all
assets.each do |asset|
  puts asset
end

# Fetch a specific assets via uuid (uuid=c3d5fc64-3a43-4d3a-a167-473dfeb1edd3)
asset = client.assets.find('c3d5fc64-3a43-4d3a-a167-473dfeb1edd3')

# Delete asset without loading it first
client.assets.delete('c3d5fc64-3a43-4d3a-a167-473dfeb1edd3')

# delete the asset instance (loading first the asset)
asset.delete
```

### Coupons

Coupons can be used to offer customers a discount or promotion, or as a general proximity marketing asset. [See Passworks API](https://github.com/passworks/passworks-api/blob/master/v2/sections/coupon.md) for mode information.

```ruby
# Create a coupon campaign
coupon_campaign = client.coupons.create({
  name: "my first coupon campaign",
  icon_id: "c3d5fc64-3a43-4d3a-a167-473dfeb1edd3"
})

# Add a pass the the coupon campaign
# see [Coupon API documentation for details about the valid coupon fields
# https://github.com/passworks/passworks-api/blob/master/sections/coupon.md
coupon_pass = coupon_campaign.passes.create({
  primary_fields: [
    {
      key: "key1",
      label: "label1",
      value: "value1"
    }
  ]
})

# Fetch and print all passes from the `coupon_campaign` campaign
coupon_campaign.passes.all.each do |coupon_pass|
  puts coupon_pass
end

# send push notification all users of a coupon campaign
coupon_campaign.push

# Send push notification to the users of a given passe of the `coupon_campaign`
coupon_campaign.passes.all.first.push

# Update coupon pass
# the `update` method returns the updated PassResource instance
coupon_pass         = coupon_campaign.passes.all.first
updated_coupon_pass = coupon_pass.update({
  primary_fields: [
    {
      key: "key2",
      label: "label2",
      value: "value2"
    }
  ]
})
```

### Store Cards

The Passworks API can be used to create loyalty or event tier programs to reward your customers for using your services. [See Passworks API](https://github.com/passworks/passworks-api/blob/master/v2/sections/store_card.md) for mode information.


```ruby
# Create a store card campaign
coupon_campaign = client.store_cards.create({
  name: "my first store card campaign",
  icon_id: "c3d5fc64-3a43-4d3a-a167-473dfeb1edd3"
})

# Add a pass the the store card campaign
# see [Store Card API documentation for details about the valid store card fields
# https://github.com/passworks/passworks-api/blob/master/sections/store_card.md
store_card_pass = store_card_campaign.passes.create({
  primary_fields: [
    {
      key: "key1",
      label: "label1",
      value: "value1"
    }
  ]
})

# Fetch and print all passes from the `store_card_campaign` campaign
store_card_campaign.passes.all.each do |store_card_pass|
  puts store_card_pass
end

# send push notification all users of a store card campaign
store_card_campaign.push

# Send push notification to the users of a given passe of the `store_card_campaign`
store_card_campaign.passes.all.first.push

# Update store card pass
# the `update` method returns the updated PassResource instance
store_card_pass     = store_card_campaign.passes.all.first
updated_coupon_pass = store_card_pass.update({
  primary_fields: [
    {
      key: "key2",
      label: "label2",
      value: "value2"
    }
  ]
})
```

### Event Tickets

Event Tickets are passes used for events such as concerts, movie tickets, galas, meetings or other types of activity that happen in a specific time or day. [See Passworks API](https://github.com/passworks/passworks-api/blob/master/v2/sections/event_ticket.md) for mode information.

```ruby
# Create a event ticket campaign
event_ticket_campaign = client.event_tickets.create({
  name: "my first event ticket campaign",
  icon_id: "c3d5fc64-3a43-4d3a-a167-473dfeb1edd3"
})

# Add a pass the the event ticket campaign
# see [Event Ticket API documentation for details about the valid event ticket fields
# https://github.com/passworks/passworks-api/blob/master/sections/event_ticket.md
event_ticket_campaign = event_ticket_campaign.passes.create({
  primary_fields: [
    {
      key: "key1",
      label: "label1",
      value: "value1"
    }
  ]
})

# Fetch and print all passes from the `event_ticket_campaign` campaign
event_ticket_campaign.passes.all.each do |event_ticket_pass|
  puts event_ticket_pass
end

# send push notification all users of a store card campaign
event_ticket_campaign.push

# Send push notification to the users of a given passe of the `event_ticket_campaign`
event_ticket_campaign.passes.all.first.push

# Update event ticket pass
# the `update` method returns the updated PassResource instance
event_ticket_pass         = event_ticket_campaign.passes.all.first
updated_event_ticket_pass = event_ticket_pass.update({
  primary_fields: [
    {
      key: "key2",
      label: "label2",
      value: "value2"
    }
  ]
})
```

### Bording Passes

Boarding passes can be airplane, bus, train, or boat tickets. You also can create generic boarding passes. [See Passworks API](https://github.com/passworks/passworks-api/blob/master/v2/sections/boarding_pass.md) for mode information.


```ruby
# Create a boarding pass campaign
boarding_pass_campaign = client.boarding_passes.create({
  name: "my first boarding pass campaign",
  icon_id: "c3d5fc64-3a43-4d3a-a167-473dfeb1edd3",
  transit_type: "air"
})

# Add a pass the the boarding pass campaign
# see [Boarding Pass API documentation for details about the valid boarding passe fields
# https://github.com/passworks/passworks-api/blob/master/sections/boarding_pass.md
boarding_pass_pass = boarding_pass_campaign.passes.create({
  primary_fields: [
    {
      key: "key1",
      label: "label1",
      value: "value1"
    }
  ]
})

# Fetch and print all passes from the `boarding_pass_campaign` campaign
boarding_pass_campaign.passes.all.each do |boarding_pass|
  puts boarding_pass
end

# send push notification all users of a boarding pass campaign
boarding_pass_campaign.push

# Send push notification to the users of a given passe of the `boarding_pass_campaign`
boarding_pass_campaign.passes.all.first.push

# Update event ticket pass
# the `update` method returns the updated PassResource instance
boarding_pass_pass         = boarding_pass_campaign.passes.all.first
updated_boarding_pass_pass = boarding_pass_pass.update({
  primary_fields: [
    {
      key: "key2",
      label: "label2",
      value: "value2"
    }
  ]
})
```

### Generic

Generic passes can be used for anything that doesn't fit in the other pass categories. [See Passworks API](https://github.com/passworks/passworks-api/blob/master/v2/sections/generic.md) for mode information.

```ruby
# Create a generic pass campaign
generic_campaign = client.boarding_passes.create({
  name: "my first generic campaign",
  icon_id: "c3d5fc64-3a43-4d3a-a167-473dfeb1edd3"
})

# Add a pass the the generic campaign
# see [Generic Pass API documentation for details about the valid generic passe fields
# https://github.com/passworks/passworks-api/blob/master/sections/generic.md
generic_pass = generic_campaign.passes.create({
  primary_fields: [
    {
      key: "key1",
      label: "label1",
      value: "value1"
    }
  ]
})

# Fetch and print all passes from the `generic_campaign` campaign
generic_campaign.passes.all.each do |generic_pass|
  puts generic_pass
end

# send push notification all users of an generic pass campaign
generic_campaign.push

# Send push notification to the users of a given passe of the `generic_campaign`
generic_campaign.passes.all.first.push

# Update event ticket pass
# the `update` method returns the updated PassResource instance
generic_pass         = generic_campaign.passes.all.first
updated_generic_pass = generic_pass.update({
  primary_fields: [
    {
      key: "key2",
      label: "label2",
      value: "value2"
    }
  ]
})
```

## Updating campaign passes in a single request

It's possible to update the passes presentation fields (`primary_fields`, `secondary_fields`, `auxiliary_fields` and `back_fields`) using the Campaign data in a single request.

For that you only need to follow the 2 steps:

1. Update the campaign with the intended information.
2. Call the `merge` method in the campaign, this method merges the presentation fields of the campaign with the passes information.

```ruby
	# Find the campaign that you wish to update
	campaign = client.coupons.find("c3d5fc64-3a43-4d3a-a167-473dfeb1edd3")
	
	# Update the campaign
	campaign.update({
		secondary_fields: [
			{
				key: "date",
				label: "Promotion expires at",
				value: "31/12/2015"
			}
		]
	})
	
	# Update the campaign passes
	campaign.merge
```


> IMPORTANTE: This method updates all passes `beacons` and `locations` (geo locations) with the Campaign defined ones, overriding the existing in the passes.


## Understanding behaviour fields (fixed vs dynamic content)

The presentation fields (`primary_fields`, `secondary_fields`, `auxiliary_fields` and `back_fields`) have a new (`behaviour`) attribute. This attribute can have one of two values: `fixed` or `dynamic` _(by default the `behaviour` is set to `fixed`)_.

- fixed

	`fixed` means that the value is `static`: every pass will have the same `label` and `value` for this field.
	So when you call the  `merge` method in the Ruby client this field will be added or overriden (if the field with the same `key` exists) in every pass even if you had previously customized the value per pass. Don't use the type of field for custom fields in your passes eg: __name__, __client id__, __ticket number__ ,etc. This type of _behaviour_ is a good fit for fields that are the same across all passes eg: `event date`, `event location`, `flight number`, etc.

- dynamic

	The `dynamic` _behaviour_ defines the field as a custom updated field that shouldn't be updated on a bulk update when the `merge` method is called.
	This field will only be updated when the user updates that field specifically for that pass. This type of _behaviour_ is a good fit for custom fields like `ticket number`, `user name`, `boarding number`, `seat number`, etc..
	

## Documentation

For more information about the API please please refere to [https://github.com/passworks/passworks-api](https://github.com/passworks/passworks-api)

For more examples about the Ruby client try browsing the [wiki](https://github.com/passworks/passworks-ruby/wiki)


## Help us make it better

Please tell us how we can make the Ruby client better. If you have a specific feature request or if you found a bug, please use GitHub issues. Fork these docs and send a pull request with improvements.

To talk with us and other developers about the API [open a support ticket](https://github.com/passworks/passworks-ruby/issues) or mail us at `api at passworks.io` if you need to talk to us.
