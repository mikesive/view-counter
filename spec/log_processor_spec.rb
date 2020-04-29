# frozen_string_literal: true

require './spec/helpers/fixture_helper'
require './lib/log_processor'

RSpec.describe LogProcessor do
  let(:entries) { FixtureHelper.load_visits }
  let(:log_path) { FixtureHelper.path('log.txt') }
  let(:store) { double('Store', record: nil) }

  describe '.process' do
    subject do
      described_class.process(log_path) { |r, ip| store.record(r, ip) }
    end

    context 'when log is badly formatted' do
      let(:log_path) { FixtureHelper.path('badly_formatted_log.txt') }
      it 'should raise an error' do
        expect { subject }.to raise_error(
          ArgumentError, 'Bad formatting in log file'
        )
      end
    end

    context 'when no block given' do
      subject { described_class.process(log_path) }

      it 'should raise an error' do
        expect { subject }.to raise_error(
          ArgumentError, 'LogProcessor.process requires a block argument'
        )
      end
    end

    it 'should yield each entry to the block to call record' do
      entries.each do |(resource, ip)|
        expect(store).to receive(:record).with(resource, ip)
      end

      subject
    end
  end
end
