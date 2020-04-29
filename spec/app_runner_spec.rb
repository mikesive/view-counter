# frozen_string_literal: true

require './spec/helpers/fixture_helper'
require './lib/app_runner'

RSpec.describe AppRunner do
  let(:log_path) { FixtureHelper.path('log.txt') }
  let(:expected_output) { File.read(FixtureHelper.path('expected_output.txt')) }
  let(:runner) { described_class.new(log_path) }

  describe '#run' do
    subject { runner.run }

    it { expect(runner).to respond_to(:run) }

    context 'with non-string path' do
      [nil, 1, 2.3, {}].each do |invalid_arg|
        context invalid_arg.to_s do
          let(:log_path) { invalid_arg }

          it 'should raise an error' do
            expect { subject }.to raise_error(
              ArgumentError, 'Given path is not a valid filepath'
            )
          end
        end
      end
    end

    context 'with non-existent file path' do
      let(:log_path) { '/some/non/existent/file.txt' }

      it 'should raise an error' do
        expect { subject }.to raise_error(
          ArgumentError, 'Given path is not a valid filepath'
        )
      end
    end

    it 'should output view counts correctly' do
      expect { subject }.to output(expected_output).to_stdout
    end
  end
end
