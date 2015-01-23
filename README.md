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

## Documentation

For more information about the API please please refere to [https://github.com/passworks/passworks-api](https://github.com/passworks/passworks-api)

For more examples about the Ruby client try browsing the [wiki](https://github.com/passworks/passworks-ruby/wiki)


## Help us make it better

Please tell us how we can make the Ruby client better. If you have a specific feature request or if you found a bug, please use GitHub issues. Fork these docs and send a pull request with improvements.

To talk with us and other developers about the API [open a support ticket](https://github.com/passworks/passworks-ruby/issues) or mail us at `api at passworks.io` if you need to talk to us.
