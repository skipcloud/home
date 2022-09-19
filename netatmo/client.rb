# frozen_string_literal: true

require 'faraday'

module Netatmo
  # A Netatmo Client class that can interact with
  # the netatmo API to pull weather station data
  class Client
    NETATMO_API_URL = 'https://api.netatmo.com'

    def initialize
      throw StandardError, 'Client secrets not found' unless env_vars_set?
    end

    def fetch_data
      puts request_token.body
    end
  end
end
