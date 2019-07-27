# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SuperDispatch::Client do
  let(:api_base) { 'http://api_base.com' }
  let(:client_id) { '123' }
  let(:client_secret) { '321321321' }
  let(:path) { 'v1/public/orders' }
  let(:basic_authorization_token) { 'Basic MTIzOjMyMTMyMTMyMQ==' }
  let(:access_token) { 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' } 
  let(:bearer_authorization_token) { "Bearer #{access_token}" }

  before do
    SuperDispatch.configure do |config|
      config.api_base       = api_base
      config.client_id      = client_id
      config.client_secret  = client_secret
    end
  end

  subject { SuperDispatch::Client.new }

  describe '#access_token' do
    it 'should call authenticate if is not defined' do
      expect(subject).to receive(:authenticate).and_return({'access_token' => access_token})

      subject.send(:access_token)
    end
  end

  describe '#authenticate' do
    it 'should call post method of main_resource with specific parameters' do
      expect_any_instance_of(RestClient::Resource).to(
        receive(:post)
          .with({}, Authorization: 'Basic MTIzOjMyMTMyMTMyMQ==')
          .once
      )

      subject.send(:authenticate)
    end
  end

  describe '#basic_authorization_token' do
    # For this test I precalculate the expected value hashing 123:321321321 in base 64
    it { expect(subject.send(:basic_authorization_token)).to eq('Basic MTIzOjMyMTMyMTMyMQ==') }
  end

  describe '#bearer_access_token' do
    # before do
    #   allow(subject).to receive(:authenticate).and_return({'access_token' => access_token})
    # end

    it { expect(subject.send(:bearer_access_token, access_token)).to eq(bearer_authorization_token) }
  end

  describe '#parse_response' do
    context 'with nil response' do
      it { expect(subject.send(:parse_response)).to eq(nil) }
    end

    context 'with json string response' do
      before do
        class String
          def code
            200
          end
        end
      end

      it { expect(subject.send(:parse_response, '{"access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"}')).to eq({"access_token" => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"}) }
    end

    context 'with 204 code' do
      before do
        class String
          def code
            204
          end
        end
      end

      it { expect(subject.send(:parse_response, '')).to eq({}) }
    end
  end

  context 'request methods' do
    let(:params) do
      {
        carrier_email: 'RMOODY@RRRWAREHOUSE.COM',
        carrier_name: 'RMOODY'
      }
    end

    before do
      allow(subject).to receive(:authenticate).and_return({'access_token' => access_token})
    end

    it { expect(subject).to respond_to(:get) }
    it { expect(subject).to respond_to(:post) }
    it { expect(subject).to respond_to(:put) }
    it { expect(subject).to respond_to(:delete) }

    describe "#get" do
      context 'without params' do
        it 'has to call Rest Client #get with correct parameters' do
          expect_any_instance_of(RestClient::Resource).to receive(:get).with(
            params: {},
            Authorization: bearer_authorization_token
          )
  
          subject.get(path)
        end
      end
  
      context 'with params' do
        it 'has to call Rest Client #get with correct parameters' do
          expect_any_instance_of(RestClient::Resource).to receive(:get).with(
            params: params,
            Authorization: bearer_authorization_token
          )
  
          subject.get(path, params)
        end
      end
    end
    
    describe "#post" do
      it 'has to call Rest Client #post with correct parameters' do
        expect_any_instance_of(RestClient::Resource).to receive(:post).with(
          params.to_json,
          Authorization: bearer_authorization_token,
          example: :header
        )

        subject.post(path, params, { example: :header })
      end
    end
  
    describe "#put" do
      it 'has to call Rest Client #put with correct parameters' do
        expect_any_instance_of(RestClient::Resource).to receive(:put).with(
          params.to_json,
          Authorization: bearer_authorization_token,
          example: :header
        )

        subject.put(path, params, { example: :header })
      end
    end
  
    describe "#delete" do
      it 'has to call Rest Client #delete with correct parameters' do
        expect_any_instance_of(RestClient::Resource).to receive(:delete).with(
          Authorization: bearer_authorization_token,
          example: :header
        )

        subject.delete(path, { example: :header })
      end
    end
  end
end