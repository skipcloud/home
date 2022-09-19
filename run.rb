require './netatmo/client'

n = Netatmo::Client.new
n.fetch_data
