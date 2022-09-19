# frozen_string_literal: true

require_relative './auth'
require 'faraday'
require 'faraday/retry'

module Netatmo
  # A Netatmo Client class that can interact with
  # the netatmo API to pull weather station data
  class Client
    include Auth
    NETATMO_API_URL = 'https://api.netatmo.com'

    def initialize
      @conn = Faraday.new(NETATMO_API_URL) do |c|
        c.request :url_encoded
        c.request :retry
        c.response :json
      end

      authenticate
    end

    def fetch_data
      puts @access_token
    end
  end
end
