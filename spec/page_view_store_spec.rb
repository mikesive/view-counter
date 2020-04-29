# frozen_string_literal: true

require 'spec_helper'
require './lib/page_view_store'
require './spec/helpers/fixture_helper'

RSpec.describe PageViewStore do
  let(:entries) { FixtureHelper.load_visits }
  let(:resource) { entries.first.first }
  let(:store) { described_class.new }

  describe '#record' do
    it { expect(store).to respond_to(:record) }

    it 'stores multiple entries independently' do
      entries.each { |(r, ip)| store.record(r, ip) }

      expect(store.counts['/page/1']).to eq(2)
      expect(store.counts['/page/2']).to eq(3)
      expect(store.counts['/page_3']).to eq(4)
    end
  end

  describe '#sorted_counts' do
    subject { store.sorted_counts }

    it 'should sort in order of counts' do
      entries.each { |(r, ip)| store.record(r, ip) }
      expect(subject.map(&:first)).to eq(['/page_3', '/page/2', '/page/1'])
      expect(subject.map(&:last)).to eq([4, 3, 2])
    end
  end
end
