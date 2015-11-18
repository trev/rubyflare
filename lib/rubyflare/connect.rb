module Rubyflare
  class Connect

    attr_reader :response

    API_URL = "https://api.cloudflare.com/client/v4/"

    def initialize(email, api_key)
      @email = email
      @api_key = api_key
    end
    
    %i(get post).each do |method_name|

      define_method(method_name) do |endpoint, options = {}|
        url = self.class.build_url(endpoint, options)

        response = Curl.send(method_name, url) do |http|
          http.headers['X-Auth-Email'] = @email
          http.headers['X-Auth-Key'] = @api_key
        end
        @response = Rubyflare::Response.new(method_name, url, response.body)
      end
    end

    def self.build_url(endpoint, options = {})
      url = API_URL + endpoint
      url += "?#{URI.encode_www_form(options)}" unless options.empty?
      url
    end

  end
end


