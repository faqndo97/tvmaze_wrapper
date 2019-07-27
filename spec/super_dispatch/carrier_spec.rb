# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SuperDispatch::Carrier do
  let(:carrier_id) { 1 }
  let(:carrier_name) { 'RMOODY' }
  let(:carrier_email) { 'RMOODY@RRRWAREHOUSE.COM' }

  subject { SuperDispatch::Client.new }

  before do
    SuperDispatch.configure do |config|
      config.api_base       = 'http://api_base.com'
      config.client_id      = '123'
      config.client_secret  = '321321321'
    end

    allow(subject).to receive(:authenticate).and_return('Basic MTIzOjMyMTMyMTMyMQ==')
  end

  describe '#find_carrier_by_guid' do
    it 'has to call Client #get' do
      expect(subject).to receive(:get).with("v1/public/carriers/#{carrier_id}")

      subject.find_carrier_by_guid(carrier_id)
    end
  end

  describe '#find_carrier_by_params' do
    it 'has to call Client #get with specific parameters' do
      expect(subject).to receive(:get).with("v1/public/carriers/search", { carrier_email: carrier_email, carrier_name: carrier_name })

      subject.find_carrier_by_params(name: carrier_name, email: carrier_email)
    end
  end
end