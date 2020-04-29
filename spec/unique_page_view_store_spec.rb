# frozen_string_literal: true

require 'spec_helper'
require './lib/unique_page_view_store'
require './spec/helpers/fixture_helper'

RSpec.describe UniquePageViewStore do
  let(:entries) { FixtureHelper.load_visits }
  let(:resource) { entries.first.first }
  let(:store) { described_class.new }

  describe '#record' do
    it { expect(store).to respond_to(:record) }

    it 'stores unique views' do
      entries.each { |(r, ip)| store.record(r, ip) }

      expect(store.counts['/page/1']).to eq(2)
      expect(store.counts['/page/2']).to eq(1)
      expect(store.counts['/page_3']).to eq(3)
    end
  end
end
