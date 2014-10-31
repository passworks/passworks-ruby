ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest-vcr'
require 'webmock/minitest'

require 'pry'
require 'pry-byebug'

MinitestVcr::Spec.configure!

require File.expand_path './support/vcr_setup.rb', __dir__

require File.expand_path '../lib/passworks.rb'   , __dir__

Passworks.configure do |config|
  config.api_username = ENV['PASSWORKS_API_USERNAME']
  config.api_secret   = ENV['PASSWORKS_API_SECRET']
  config.endpoint     = 'http://api.passworks.git:3000'
end

def test_asset_path(file)
  File.expand_path "./support/assets/#{file}", __dir__
end

def icon_asset_instance
  @icon_asset_instance ||= @client.assets.create({
    file: test_asset_path("logo.png"),
    asset_type: 'icon'
  })
end
