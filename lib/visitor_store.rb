# frozen_string_literal: true

# The VisitorStore class is used to track which
# resources have been accessed by which visitors
class VisitorStore
  attr_reader :page_visitors

  def initialize
    @page_visitors = {}
  end

  def record(resource, ip)
    page_visitors[key(resource, ip)] = true
  end

  def visited?(resource, ip)
    page_visitors[key(resource, ip)] || false
  end

  private

  def key(resource, ip)
    [resource, ip].join('-')
  end
end
