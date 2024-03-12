# frozen_string_literal: true

module ApiServices
  class ImportService
    BASE_URL = 'https://beta.01cxhdz3a8jnmapv.com/api/v1/assignment'

    class AuthenticationError < StandardError; end
    class APIRequestError < StandardError; end

    def self.authenticate
      credentials = Rails.application.credentials.api
      auth_url = "#{BASE_URL}/token/"
      auth_payload = {
        grant_type: 'password',
        client_id: credentials[:client_id],
        client_secret: credentials[:client_secret],
        username: credentials[:username],
        password: credentials[:password]
      }

      begin
        response = RestClient.post(auth_url, auth_payload.to_json, content_type: :json)
        JSON.parse(response.body)['access_token']
      rescue RestClient::ExceptionWithResponse => e
        raise AuthenticationError, "Authentication Failed. #{e.response.body}"
      end
    end

    def self.get_employees(access_token)
      employees_url = "#{BASE_URL}/employee/list"
      headers = { Authorization: "Bearer #{access_token}"}

      begin
        response = RestClient.get(employees_url, headers)
        JSON.parse(response.body)
      rescue
        raise APIRequestError, "API request failed. #{e.response.body}"
      end
    end
  end
end
