# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SuperDispatch::Order do
  let(:api_base) { 'http://api_base.com' }
  let(:client_id) { '123' }
  let(:client_secret) { '321321321' }
  let(:basic_authorization_token) { 'Basic MTIzOjMyMTMyMTMyMQ==' }
  let(:order_id) { 1 }

  before do
    SuperDispatch.configure do |config|
      config.api_base       = api_base
      config.client_id      = client_id
      config.client_secret  = client_secret
    end

    allow(subject).to receive(:authenticate).and_return(basic_authorization_token)
  end

  subject { SuperDispatch::Client.new }

  describe '#orders' do
    it 'has to call Client #get' do
      expect(subject).to receive(:get).with('v1/public/orders')

      subject.orders
    end
  end

  describe '#create_order' do
    let(:order_guid) { '2e2dbbf9-4765-4bcc-8329-4864c6f62972' } 
    let(:order_creation_response) do
      {
        'data' => {
          'object' => {
            'guid' => order_guid
          }
        }
      }
    end

    before do
      allow(subject).to receive(:post).and_return('{}')
    end

    it 'has to call Client #post' do
      expect(subject).to receive(:post).with('v1/public/orders', {})

      subject.create_order({})
    end

    it 'has to call #post_to_central_dispatch if central_dispatch parameter is true' do
      allow(subject).to receive(:post).with('v1/public/orders', {}).and_return(order_creation_response)

      expect(subject).to receive(:post_order_to_cd).with(order_guid)

      subject.create_order({}, central_dispatch: true)
    end
  end

  describe '#order' do
    it 'has to call Client #get' do
      expect(subject).to receive(:get).with("v1/public/orders/#{order_id}")

      subject.send(:order, order_id)
    end
  end

  describe '#update_order' do
    before do
      allow(subject).to receive(:order).and_return({'object' => {}})
    end

    it 'has to call Client #put' do
      expect(subject).to receive(:put).with("v1/public/orders/#{order_id}", {})

      subject.send(:update_order, order_id, {})
    end

    it 'has to call Client #order' do
      allow(subject).to receive(:put)
      
      expect(subject).to receive(:order).with(order_id).once

      subject.send(:update_order, order_id, {})
    end
  end

  describe '#delete' do
    it 'has to call Client #delete' do
      expect(subject).to receive(:delete).with("v1/public/orders/#{order_id}")

      subject.send(:delete_order, order_id)
    end
  end

  describe '#post_order_to_cd' do
    it 'has to call Client #post' do
      expect(subject).to receive(:post).with("v1/public/orders/#{order_id}/post_to_cd")

      subject.post_order_to_cd(order_id)
    end
  end

  describe '#remove_order_from_cd' do
    it 'has to call Client #delete' do
      expect(subject).to receive(:delete).with("v1/public/orders/#{order_id}/remove_from_cd")

      subject.remove_order_from_cd(order_id)
    end
  end
end
