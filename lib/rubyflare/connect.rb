module Rubyflare
  class Connect

    attr_reader :response

    API_URL = "https://api.cloudflare.com/client/v4/"

    def initialize(email, api_key)
      @email = email
      @api_key = api_key
    end
    
    %i(get post put patch delete).each do |method_name|
      define_method(method_name) do |endpoint, options = {}|
        options = options.to_json unless method_name == :get
        response = Curl.send(method_name, API_URL + endpoint, options) do |http|
          http.headers['X-Auth-Email'] = @email
          http.headers['X-Auth-Key'] = @api_key
          http.headers['Content-Type'] = 'application/json'
          http.headers['User-Agent'] = 'Rubyflare/1.01'
        end
        @response = Rubyflare::Response.new(method_name, endpoint, response.body_str)
      end
    end
  end
end


