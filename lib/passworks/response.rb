module Passworks
  class Response

    attr_reader :client, :response, :data

    def initialize(client, response)
      @client     = client
      @response   = response
      @data       = response.body
    end

    def paginated?
      (!headers['x-total-pages'].nil?) && (headers['x-total-pages'].to_i > 1)
    end

    def next_page?
      !headers['x-next-page'].nil?
    end

    def next_page
      headers['x-next-page'].to_i if next_page?
    end

    def previous_page?
      !headers['x-prev-page'].nil?
    end

    def previous_page
      headers['x-prev-page'].to_i if previous_page?
    end

    def http_status
      @response[:status].to_i
    end

    def ok?
      (http_status >= 200) && (http_status < 300)
    end

    def headers
      @response.env[:response_headers] || {}
    end

    def size
      return headers['x-total'].to_i unless headers['x-total'].nil?
      return data.size if data.is_a?(Array)
      return 0
    end

    def next_page_url
      return nil unless next_page?
      params = { page: next_page }
    end

  end
end