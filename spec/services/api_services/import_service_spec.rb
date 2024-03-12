# frozen_string_literal: true

# spec/services/api_services/import_service_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ApiServices::ImportService do
  describe '.authenticate' do
    let(:auth_url) { "#{ApiServices::ImportService::BASE_URL}/token/" }
    let(:credentials) { Rails.application.credentials.api }

    it 'returns an access token on successful authentication' do
      auth_payload = {
        grant_type: 'password',
        client_id: credentials[:client_id],
        client_secret: credentials[:client_secret],
        username: credentials[:username],
        password: credentials[:password]
      }
      stub_request(:post, auth_url)
        .with(body: auth_payload)
        .to_return(body: { 'access_token' => 'mock_access_token' }.to_json, status: 200)

      access_token = described_class.authenticate
      expect(access_token).to eq('mock_access_token')
    end

    it 'raises AuthenticationError on authentication failure' do
      stub_request(:post, auth_url).to_return(status: 401, body: 'Unauthorized')

      expect do
        described_class.authenticate
      end.to raise_error(ApiServices::ImportService::AuthenticationError, /Authentication Failed/)
    end
  end

  describe '.get_employees' do
    let(:access_token) { 'mock_access_token' }
    let(:employees_url) { "#{ApiServices::ImportService::BASE_URL}/employee/list" }

    it 'returns employee data on successful API request' do
      stub_request(:get, employees_url)
        .with(headers: { 'Authorization' => "Bearer #{access_token}" })
        .to_return(body: [{ 'id' => '1', 'name' => 'Name Example' }].to_json, status: 200)

      employees = described_class.get_employees(access_token)
      expect(employees).to be_an(Array)
      expect(employees.first['id']).to eq('1')
      expect(employees.first['name']).to eq('Name Example')
    end

    it 'raises APIRequestError on API request failure' do
      stub_request(:get, employees_url).to_return(status: 500, body: 'Internal Server Error')

      expect { described_class.get_employees(access_token) }
        .to raise_error(ApiServices::ImportService::APIRequestError, /API request failed/)
    end
  end
end
