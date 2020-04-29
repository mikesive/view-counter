# frozen_string_literal: true

# The PageViewStore class is used to track the number
# of total views for each resource.
class PageViewStore
  attr_reader :counts

  def initialize
    @counts = {}
  end

  def record(resource, _ip)
    counts[resource] ||= 0
    counts[resource] += 1
  end

  def sorted_counts
    counts.sort_by { |_resource, count| count * -1 }
  end
end
