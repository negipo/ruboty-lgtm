require 'faraday'
require 'faraday_middleware'

module Ruboty
  module Lgtm
    class Client
      DEFAULT_ENDPOINT = 'http://lgtm.herokuapp.com'

      GOOGLE_IMAGE_API_URL = 'http://ajax.googleapis.com/ajax/services/search/images'

      def initialize(options)
        @options = options
      end

      def generate
        url = get

        if url
          File.join(endpoint, url)
        end
      end

      private

      def get
        resource['unescapedUrl'] if resource
      rescue => exception
        Ruboty.logger.error("Error: #{self}##{__method__} - #{exception}")
        nil
      end

      def resource
        return @resource if defined?(@resource)

        @resource = nil
        if data = response.body['responseData']
          if results = data['results']
            @resource = results.sample
          end
        end

        @resource
      end

      def response
        connection.get(url, params)
      end

      def url
        GOOGLE_IMAGE_API_URL
      end

      def params
        default_params.merge(given_params).reject {|key, value| value.nil? }
      end

      def given_params
        {
          q: @options[:query],
        }
      end

      def default_params
        {
          rsz: 8,
          safe: 'active',
          v: '1.0',
          as_filetype: 'gif',
          imgsz: 'large',
          as_sitesearch: 'tumblr.com'
        }
      end

      def connection
        Faraday.new do |connection|
          connection.adapter :net_http
          connection.response :json
        end
      end

      def endpoint
        @options[:endpoint] || DEFAULT_ENDPOINT
      end
    end
  end
end
