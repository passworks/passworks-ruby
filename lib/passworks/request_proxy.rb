# encoding: UTF-8

module Passworks
  class RequestProxy

    include Passworks::Inflector

    # @return [Passworks::Client] fsdfsd fsf sdfsd fsdf
    attr_reader :client

    # @return [String] Current collection name (ex: assets, campaigns, boarding_passes, coupons, event_tickets)
    attr_reader :collection_name

    # @return [String] Collection UUID
    attr_reader :collection_uuid

    def initialize(client, collection_name, collection_uuid=nil, options={})
      @collection_name = collection_name
      @collection_uuid = collection_uuid
      @client          = client
      @options         = options
    end

    # Fetch all instances of a given collection (Assests, Boarding Passes, Coupons, Generics and Store Cards)
    # @param options [Hash] options
    # @option options [Integer] :per_page Changes the number of results per page
    # @option options [Integer] :offset 0 The offset to start from
    # @example Fetching the very first coupon (campaign) without having to pull all the elements first from the server
    #   client.coupons.all(per_page: 1).first
    # @example Fetching the very first coupon pass from the first coupon (campaign) without having to pull all the elements first from the server
    #   client.coupons.all(per_page: 1).first.passes.all(per_page: 1).first
    # @return [Passworks::CollectionProxy]
    def all(options={})
      options = { query: options } unless options.empty?
      CollectionProxy.new(client, collection_name, collection_uuid, options)
    end


    # Finds a given campaing or passe given the context
    # @param uuid [String] The campaign or pass UUID
    # @example Fetching a coupon campaign
    #   coupon_campaign = client.coupons.find('c3d5fc64-3a43-4d3a-a167-473dfeb1edd3')
    # @example Fetching a pass for the first coupon campaign
    #   pass = client.coupons.all(per_page: 1).first.passes.find('c3d5fc64-3a43-4d3a-a167-473dfeb1edd3')
    # @return [PassResource.new or CampaignResource]
    def find(uuid)
      if collection_uuid
        fetch_url = "#{collection_name}/#{collection_uuid}/passes/#{uuid}"
      else
        fetch_url = "#{collection_name}/#{uuid}"
      end
      response = client.get(fetch_url)
      resource_class.new(client, collection_name, response.data)
    end

    # Creates a campaing instance (Assests, Boarding Passes, Coupons, Generics and Store Cards) or a passe depending of the caller context
    # @param data [Hash] data Campaign or pass data
    # @param params [Hash] params Extra arguments to send with the request
    # @option params [Boolean] merge: (true) Merge passed pass data with the campaign incase you are creating a passe instance.
    # @example Create a coupon (campaign)
    #   client.coupons.create({
    #     name: 'My First Coupon',
    #     icon_id: 'c3d5fc64-3a43-4d3a-a167-473dfeb1edd3'
    #   })
    # @example Create a "empty" passe for the first coupon campaign
    #   client.coupons.all(per_page: 1).first.passes.create()
    # @return [Passworks::CampaignResource or Passworks::PassResource] depending of the calling a {Passworks::CampaignResource} or {Passworks::PassResource} is returned.
    def create(data={}, params={})

      if collection_name.to_s == 'assets' && collection_uuid.nil?
        raise Passworks::Exceptions::FileNotFound.new("Can't find file #{data[:file]}") unless data.has_key?(:file) && File.exists?(data[:file])
        data[:file] = ::Faraday::UploadIO.new(data[:file], "image/#{data[:file].split('.').last.downcase}")
      end

      if collection_uuid
        content = {
          body: {
            'pass' => data
          }.merge(params)
        }
        fetch_url = "#{collection_url}/passes"
      else
        content = {
          body: {
            single_name.to_sym => data
          }.merge(params)
        }
        fetch_url = collection_url
      end

      response = client.post(fetch_url, content)
      resource_class.new(client, collection_name, response.data)

    end

    # Delets a campaing (Assests, Boarding Passes, Coupons, Generics and Store Cards campaign) or a pass instance
    # @param uuid [String] the UUID of the campaign or pass to delete
    # @return [Boolean]
    def delete(uuid)
      if collection_uuid
        client.delete("#{collection_name}/#{collection_uuid}/passes/#{uuid}").ok?
      else
        client.delete("#{collection_name}/#{uuid}").ok?
      end
    end

    # @!visibility private
    def collection_url
      if collection_uuid
        "#{collection_name}/#{collection_uuid}"
      else
        collection_name
      end
    end

  end
end