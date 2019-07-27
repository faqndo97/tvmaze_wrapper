# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TvmazeWrapper::Search do
  let(:show_name) { 'orange is the new black' }

  subject { TvmazeWrapper::Client.new }

  describe '#search_by_name' do
    it 'has to call Client #get' do
      expect(subject).to receive(:get).with('search/shows', {q: show_name})

      subject.search_by_name(show_name)
    end
  end

  describe '#single_search_by_name' do
    it 'has to call Client #get' do
      expect(subject).to receive(:get).with('singlesearch/shows', {q: show_name})

      subject.single_search_by_name(show_name)
    end
  end
end
