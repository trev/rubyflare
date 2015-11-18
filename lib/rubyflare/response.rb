module Rubyflare
  class Response
    attr_reader :result

    def initialize(method_name, endpoint, response)
      @result = JSON.parse(response, symbolize_names: true)

      unless successful?
        message = "Unable to #{method_name.to_s.upcase} to endpoint: " \
                  "#{endpoint}. Inspect Rubyflare::ConnectionError#response "\
                  "for further details"
        raise Rubyflare::ConnectionError.new(message, response)
      end
    end

    def successful?
      result[:success]
    end

    def errors
      results[:errors]
    end
  end
end

