# frozen_string_literal: true

module Netatmo
  # A module to help with authenticating with the Netatmo API
  module Auth
    CLIENT_ID_ENV_VAR = 'NETATMO_CLIENT_ID'
    CLIENT_SECRET_ENV_VAR = 'NETATMO_CLIENT_SECRET'
    OAUTH_TOKEN_ENDPOINT = 'https://api.netatmo.com/oauth2/token'
    NETATMO_PASSWORD_ENV_VAR = 'NETATMO_PASSWORD'

    private

    def env_vars_set?
      ENV[CLIENT_SECRET_ENV_VAR] && ENV[CLIENT_ID_ENV_VAR] && ENV[NETATMO_PASSWORD_ENV_VAR]
    end

    def request_token
      Faraday.post(
        OAUTH_TOKEN_ENDPOINT,
        data,
        {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          'Host': 'api.netatmo.com'
        }
      )
    end

    def data
      {
        client_id: ENV[CLIENT_ID_ENV_VAR],
        client_secret: ENV[CLIENT_SECRET_ENV_VAR],
        grant_type: 'password',
        username: 'skip.gibson@hey.com',
        password: ENV[NETATMO_PASSWORD_ENV_VAR],
        scope: 'read_station'
      }
    end
  end
end
