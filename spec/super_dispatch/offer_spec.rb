# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SuperDispatch::Offer do
  let(:api_base) { 'http://api_base.com' }
  let(:client_id) { '123' }
  let(:client_secret) { '321321321' }
  let(:basic_authorization_token) { 'Basic MTIzOjMyMTMyMTMyMQ==' }
  let(:order_id) { 1 }
  let(:offer_id) { 1 }
  let(:carrier_id) { 1 }
  let(:carrier_information) do
    {
      email: 'RMOODY@RRRWAREHOUSE.COM',
      usdot: 580794,
      phone: '+1 (555) 555-1234'
    }
  end

  subject { SuperDispatch::Client.new }

  before do
    SuperDispatch.configure do |config|
      config.api_base       = api_base
      config.client_id      = client_id
      config.client_secret  = client_secret
    end

    allow(subject).to receive(:authenticate).and_return(basic_authorization_token)
  end

  describe "#offers" do
    it 'has to call Client #get' do
      expect(subject).to receive(:get).with("v1/public/orders/#{order_id}/offers")

      subject.offers(order_id)
    end
  end

  describe "#create_offer" do
    context 'with an existed carrier' do
      it 'has to call Client #post' do
        expect(subject).to receive(:post).with("v1/public/orders/#{order_id}/offers", { carrier_guid: carrier_id })

        subject.create_offer(order_id, carrier: { id: carrier_id })
      end
    end

    context 'with new carrier' do
      it 'has to call Client #post with new carrier information' do
        expect(subject).to receive(:post).with(
          "v1/public/orders/#{order_id}/offers",
          {
            carrier_email: carrier_information[:email], 
            carrier_usdot: carrier_information[:usdot], 
            carrier_phone: carrier_information[:phone], 
          }
        )

        subject.create_offer(order_id, carrier: carrier_information)
      end
    end
  end
  
  describe "#offer" do
    it 'has to call Client #get' do
      expect(subject).to receive(:get).with("v1/public/orders/#{order_id}/offers/#{offer_id}")

      subject.offer(order_id, offer_id)
    end
  end

  describe "#delete_offer" do
    it 'has to call Client #get' do
      expect(subject).to receive(:delete).with("v1/public/orders/#{order_id}/offers/#{offer_id}")

      subject.delete_offer(order_id, offer_id)
    end
  end

  describe "#cancel_offer" do
    it 'has to call Client #get' do
      expect(subject).to receive(:put).with("v1/public/orders/#{order_id}/offers/#{offer_id}/cancel")

      subject.cancel_offer(order_id, offer_id)
    end
  end
end