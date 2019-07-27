# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SuperDispatch do
  it 'has a version number' do
    expect(SuperDispatch::VERSION).not_to be nil
  end

  it 'can configure gem with client keys' do
    api_base      = 'http://api_base.com'
    client_id     = '123'
    client_secret = '321321321'

    SuperDispatch.configure do |config|
      config.api_base       = api_base
      config.client_id      = client_id
      config.client_secret  = client_secret
    end

    expect(SuperDispatch.configuration.api_base).to be api_base
    expect(SuperDispatch.configuration.client_id).to be client_id
    expect(SuperDispatch.configuration.client_secret).to be client_secret
  end
end
