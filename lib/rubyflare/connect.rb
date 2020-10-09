module Rubyflare
  class Connect

    attr_reader :response

    API_URL = "https://api.cloudflare.com/client/v4/"

    # def initialize(email, api_key)
    def initialize(**options)
      if options.length == 1
        # We are using an API token
        @api_token = options[:api_token]
      elsif options.length == 2
        # Usual email and API connection
        @email = options[:email]
        @api_key = options[:api_key]
      end

    end
    
    %i(get post put patch delete).each do |method_name|
      define_method(method_name) do |endpoint, options = {}|
        options = options.to_json unless method_name == :get
        response = Curl.send(method_name, API_URL + endpoint, options) do |http|
          # Send the Bearer request if using an API Token
          unless @api_token.nil?
            http.headers['Authorization'] = "Bearer " + @api_token
          else
            http.headers['X-Auth-Email'] = @email
            http.headers['X-Auth-Key'] = @api_key
          end
          http.headers['Content-Type'] = 'application/json'
          http.headers['User-Agent'] = "Rubyflare/#{Rubyflare::VERSION}"
        end
        @response = Rubyflare::Response.new(method_name, endpoint, response.body_str)
      end
    end
  end
end


