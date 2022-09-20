# frozen_string_literal: true

require_relative './netatmo/client'

n = Netatmo::Client.new
pp n.fetch_stations_data
