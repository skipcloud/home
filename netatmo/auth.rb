# frozen_string_literal: true

module Netatmo
  # A module to help with authenticating with the Netatmo API
  module Auth
    CLIENT_ID_ENV_VAR = 'NETATMO_CLIENT_ID'
    CLIENT_SECRET_ENV_VAR = 'NETATMO_CLIENT_SECRET'
    OAUTH_TOKEN_ENDPOINT = '/oauth2/token'
    NETATMO_PASSWORD_ENV_VAR = 'NETATMO_PASSWORD'

    def self.included(_)
      throw StandardError, 'Client secrets not found' unless \
        ENV[CLIENT_SECRET_ENV_VAR] && \
        ENV[CLIENT_ID_ENV_VAR] && \
        ENV[NETATMO_PASSWORD_ENV_VAR]
    end

    def authenticate
      resp = request_token
      # TODO: check status

      @access_token = resp.body['access_token']
      @refresh_token = resp.body['refresh_token']
    end

    private

    def request_token
      @conn.post(
        OAUTH_TOKEN_ENDPOINT,
        request_token_data
      )
    end

    def request_token_data
      {
        client_id: ENV[CLIENT_ID_ENV_VAR],
        client_secret: ENV[CLIENT_SECRET_ENV_VAR],
        grant_type: 'password',
        username: 'skip.gibson@hey.com',
        password: ENV[NETATMO_PASSWORD_ENV_VAR],
        scope: 'read_station'
      }
    end

    def refresh_token
      {

      }
    end
  end
end
