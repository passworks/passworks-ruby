# passworks-ruby

Ruby bindings for the Passworks API

Passworks Ruby API client can be installed via rubygems http://rubygems.org/gems/passworks.


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
      key: "key1"
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
# the #update method returns the updated PassResource instance
coupon_pass         = coupon_campaign.passes.all.first
updated_coupon_pass = coupon_pass.update({
  primary_fields: [
    {
      key: "key2"
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
