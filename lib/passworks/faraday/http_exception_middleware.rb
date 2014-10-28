require 'passworks/exception'
require 'faraday'

module Passworks
  module Faraday
    class HttpExceptionMiddleware < ::Faraday::Middleware

      def call(env)
        @app.call(env).on_complete do |response|
          case response[:status].to_i
          when 400
            raise Passworks::Exceptions::BadRequest, error_400(response)
          when 401
            raise Passworks::Exceptions::Unauthorized, error_400(response)
          when 402
            raise Passworks::Exceptions::PaymentRequired, error_400(response)
          when 403
            raise Passworks::Exceptions::Forbidden, error_400(response)
          when 404
            raise Passworks::Exceptions::NotFound, error_400(response)
          when 405
            raise Passworks::Exceptions::MethodNotAllowed, error_400(response)
          when 412
            raise Passworks::Exceptions::PreconditionFailed, error_400(response)
          when 420
            raise Passworks::Exceptions::EnhanceYourCalm, error_400(response)
          when 422
            raise Passworks::Exceptions::UnprocessableEntity, error_400(response)
          when 500
            raise Passworks::Exceptions::InternalServerError, error_500(response, 'Internal Server Error' , 'The server encountered an unexpected condition which prevented it from fulfilling the request.')
          when 502
            raise Passworks::Exceptions::BadGateway, error_500(response, 'Bad Gateway', 'The server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.')
          when 503
            raise Passworks::Exceptions::ServiceUnavailable, error_500(response, 'Service Unavailable', 'The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.')
          when 504
            raise Passworks::Exceptions::GatewayTimeout, error_500(response, 'Gateway Timeout', 'The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server specified by the URI.')
          end
        end
      end

      def initialize(app)
        super
        @parser = nil
      end

      private
        def error_400(response)
          "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]} - #{error_body(response)}"
        end

        def error_500(response, short_description, long_description)
        end

        # {"status_code"=>412, "error_code"=>10103, "message"=>"Asset in use by 1 templates, e.g.: Cocacola"}
        def error_body(response)
          body = response[:body]
          # body gets passed as a string, not sure if it is passed as something else from other spots?
          if not body.nil? and not body.empty? and body.kind_of?(String)
            body = ::JSON.parse(body)
          end

          if body.nil?
            nil
          elsif body['message']
            "(#{body['error_code']}) #{body['message']}"
          end
        end

    end
  end
end