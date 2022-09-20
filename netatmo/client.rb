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

      try_request { authenticate }
    end

    def fetch_stations_data
      try_request { @conn.get('/api/getstationsdata', nil, headers) }
    end

    private

    def try_request(&block)
      throw ArgumentError, 'Block missing' unless block_given?
      begin
        block.call
      rescue Faraday::ClientError => e
        puts "Ah shit, you've fucked up\n#{e.response_body}"
      rescue Faraday::ServerError => e
        puts "Ah shit, the server fucked up\n#{e.response_body}"
      rescue Faraday::Error => e
        puts e.response_body
      end
    end

    def headers
      { Authorization: "Bearer #{@access_token}" }
    end
  end
end
