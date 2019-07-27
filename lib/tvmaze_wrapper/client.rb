# frozen_string_literal: true

require 'rest-client'
require 'base64'

module TvmazeWrapper
  class Client
    include Search

    def initialize
      @main_resource = RestClient::Resource.new(
        'http://api.tvmaze.com',
        headers: {
          content_type: :json,
          accept: :json
        }
      )
    end

    # Execute RestClient get request to main resource (api_base configured on your repo) on path url.
    #
    # @param path [String] path on main resource to execute request, example for get all orders: v1/public/orders.
    # @param params [Symbol Hash] query params.
    # @return [String Hash] response of get request execution.
    def get(path, params = {})
      parse_response(main_resource[path].get(params: params))
    end

    private

    attr_accessor :main_resource

    def parse_response(response = nil)
      return if response.nil?

      JSON.parse response
    end
  end
end