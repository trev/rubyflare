require 'curb'
require 'json'

module Rubyflare
  class Connect

    attr_reader :success, :error

    API_URL = "https://api.cloudflare.com/client/v4/"

    def initialize(email, api_key)
      @email = email
      @api_key = api_key

      results = Curl.get(API_URL + 'user') do |http|
        http.headers['X-Auth-Email'] = @email
        http.headers['X-Auth-Key'] = @api_key
      end

      results = JSON.parse(results.body_str, symbolize_names: true)

      @success = results[:success]

      @error = ConnectionError.new("No worky", results[:errors]) unless @success

      self
    end
  end
end
