# frozen_string_literal: true

require_relative 'visitor_store'

# The UniquePageViewStore class is used to track the number
# of unique views for each resource, by ip address.
class UniquePageViewStore < PageViewStore
  attr_reader :visitor_store

  def initialize
    super
    @visitor_store = VisitorStore.new
  end

  def record(resource, ip)
    return if visitor_store.visited?(resource, ip)

    super(resource, ip)
    visitor_store.record(resource, ip)
  end
end
