require File.expand_path 'spec_helper.rb', __dir__

describe 'Assets', :vcr do

  before do
    @client = Passworks.new
  end

  it "calling #assets method from the client should return RequestProxy" do
    @client.assets.must_be_instance_of Passworks::RequestProxy
  end

  it "fetching all assets should return CollectionProxy" do
    @client.assets.all.must_be_instance_of Passworks::CollectionProxy
  end

  it "all.to_a should return an array" do
    @client.assets.all(per_page: 1).to_a.must_be_instance_of Array
  end

  it "create and asset" do
    # check if ok
    asset = @client.assets.create({
      file: test_asset_path("logo.png"),
      asset_type: 'logo'
    })

    asset.must_be_instance_of Passworks::AssetResource
  end

  it 'fetch the asset using #find' do
    asset ||= @client.assets.create({
      file: test_asset_path("logo.png"),
      asset_type: 'logo'
    })

    # try to fetch the asset
    fetched_asset = @client.assets.find(asset.id)

    # fetched asset can't be nil
    fetched_asset.wont_be_nil

    # must must be same as
    asset.id.must_equal fetched_asset.id
  end


end