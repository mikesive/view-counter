# frozen_string_literal: true

# The Presenter simply takes in a store and generates
# a human-readable output from it
class PageViewsPresenter
  attr_reader :store

  def initialize(store)
    @store = store
  end

  def generate_output
    output = []
    output << title
    store.sorted_counts.each do |resource, count|
      output << "#{resource.ljust(30, ' ')} #{count}"
    end

    output.join("\n")
  end

  private

  def title
    return '## Unique Page Views' if store.is_a?(UniquePageViewStore)

    '## Total Page Views'
  end
end
