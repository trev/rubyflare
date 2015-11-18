module Rubyflare
  class Response
    attr_reader :body

    def initialize(method_name, endpoint, response)
      @body = JSON.parse(response, symbolize_names: true)

      unless successful?
        message = "Unable to #{method_name.to_s.upcase} to endpoint: " \
                  "#{endpoint}. Inspect Rubyflare::ConnectionError#response "\
                  "for further details"
        raise Rubyflare::ConnectionError.new(message, self)
      end
    end

    def result
      body[:result].first
    end

    def results
      body[:result]
    end

    def successful?
      body[:success]
    end

    def errors
      body[:errors]
    end

    def messages
      body[:messages]
    end
  end
end
