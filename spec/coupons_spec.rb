require File.expand_path 'spec_helper.rb', __dir__

describe 'Coupons', :vcr do

  before do
    @client = Passworks.new
  end

  it "calling #coupons method from the client should return a RequestProxy" do
    @client.coupons.must_be_instance_of Passworks::RequestProxy
  end

  it "fetching #all coupons should return a CollectionProxy" do
    @client.coupons.all.must_be_instance_of Passworks::CollectionProxy
  end

  it "#all.to_a should return an array" do
    @client.coupons.all(per_page: 1).to_a.must_be_instance_of Array
  end

  it "#create an coupon from RequestProxy object" do

    coupon = @client.coupons.create({
      name: "New coupon #{Time.now.to_s}",
      icon_id: icon_asset_instance.id
    })

    coupon.must_be_instance_of Passworks::CampaignResource

    # if you created a coupon campaing the return collection should be a "coupons"
    coupon.collection_name.must_equal "coupons"
  end

  it "#passes on a CampaignResource should return RequestProxy and #all should return an Passworks::CollectionProxy" do

    coupon = @client.coupons.create({
      name: "New coupon #{Time.now.to_s}",
      icon_id: icon_asset_instance.id
    })

    coupon.passes.must_be_instance_of Passworks::RequestProxy

    coupon.passes.all(per_page: 1).must_be_instance_of Passworks::CollectionProxy
  end

  it "create a pass for an coupon campaign" do
    coupon = @client.coupons.create({
      name: "New coupon #{Time.now.to_s}",
      icon_id: icon_asset_instance.id
    })

    coupon_pass = coupon.passes.create()

    coupon_pass.must_be_instance_of Passworks::PassResource

    coupon_pass.collection_name.must_equal "coupons"
  end


end