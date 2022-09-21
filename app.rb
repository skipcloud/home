# frozen_string_literal: true

# Polls for netatmo weather data and insert it into the database
class App
  def initialize
    @client = Netatmo::Client.new
  end

  def poll_for_data
    raw_data = @client.fetch_stations_data
    device_data(raw_data)
  end

  private

  # @param raw_data [Hashie::Mash] the raw data from the Netatmo Client
  def device_data(raw_data)
    # pay load has the main station module as the
    # only element in the devices array with additional
    # modules in that object under "modules"
    main_module = raw_data.body.devices.first
    other_modules = main_module.modules.map do |mod|
      create_mod_hash(mod)
    end

    {
      last_status_update: main_module.last_status_store,
      modules: other_modules.push(create_mod_hash(main_module))
    }
  end

  # @param mod [Hashie::Mash] a hash of device data from Netatmo weather api
  def create_mod_hash(mod)
    {
      id: mod._id,
      name: mod.module_name,
      data: mod.dashboard_data
    }
  end
end
