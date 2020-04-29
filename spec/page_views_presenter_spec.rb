# frozen_string_literal: true

require './spec/helpers/fixture_helper'
require './lib/page_views_presenter'
require './lib/page_view_store'
require './lib/unique_page_view_store'

RSpec.describe PageViewsPresenter do
  let(:presenter) { described_class.new(store) }
  let(:page_view_store) { PageViewStore.new }
  let(:unique_page_view_store) { UniquePageViewStore.new }
  let(:sorted) { [['/page/1', 5], ['/page/2', 4]] }

  before do
    allow(page_view_store).to receive(:sorted_counts).and_return(sorted)
    allow(unique_page_view_store).to receive(:sorted_counts).and_return(sorted)
  end

  describe '#generate_output' do
    subject { presenter.generate_output }
    context 'with a PageViewStore' do
      let(:store) { page_view_store }
      it 'should output correctly' do
        expect(subject).to eq(
          "## Total Page Views\n"\
          "/page/1                        5\n"\
          '/page/2                        4'
        )
      end
    end

    context 'with a UniquePageViewStore' do
      let(:store) { unique_page_view_store }
      it 'should output correctly' do
        expect(subject).to eq(
          "## Unique Page Views\n"\
          "/page/1                        5\n"\
          '/page/2                        4'
        )
      end
    end
  end
end
