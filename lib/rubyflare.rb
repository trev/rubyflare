require 'rubyflare/version'
require 'rubyflare/connect'
require 'rubyflare/response'

require 'curb'
require 'json'

module Rubyflare
  class ConnectionError < StandardError
    attr_reader :response
    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  def self.connect_with(email, api_key)
    Rubyflare::Connect.new(email: email, api_key: api_key)
  end

  def self.connect_with_token(api_token)
    Rubyflare::Connect.new(api_token: api_token)
  end
end
