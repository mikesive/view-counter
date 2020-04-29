# frozen_string_literal: true

require 'spec_helper'
require './lib/visitor_store'

RSpec.describe VisitorStore do
  let(:store) { described_class.new }
  let(:visited_resource) { '/visited' }
  let(:visitor_1) { '1.1.1.1' }
  let(:visitor_2) { '1.1.1.2' }

  describe '#record' do
    it { expect(store).to respond_to(:record) }
  end

  describe '#visited?' do
    it { expect(store).to respond_to(:visited?) }
  end

  it 'stores whether visitors viewed resources' do
    expect { store.record(visited_resource, visitor_1) }.to change {
      store.visited?(visited_resource, visitor_1)
    }.from(false).to(true)

    expect { store.record(visited_resource, visitor_1) }.not_to change {
      store.visited?(visited_resource, visitor_2)
    }.from(false)

    expect { store.record(visited_resource, visitor_1) }.not_to change {
      store.visited?(visited_resource, visitor_1)
    }.from(true)

    expect { store.record(visited_resource, visitor_2) }.to change {
      store.visited?(visited_resource, visitor_2)
    }.from(false).to(true)

    expect(store.visited?('/not_visited', visitor_1)).to eq(false)
    expect(store.visited?('/not_visited', visitor_2)).to eq(false)
  end
end
