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
    Rubyflare::Connect.new(email, api_key)
  end
end
