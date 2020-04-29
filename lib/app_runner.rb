# frozen_string_literal: true

require_relative 'log_processor'
require_relative 'page_view_store'
require_relative 'unique_page_view_store'
require_relative 'page_views_presenter'

# The AppRunner class should do some basic validation
# of the command line arguments and then set up and run
# the other objects/processes
class AppRunner
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def run
    validate_path!

    stores = [PageViewStore.new, UniquePageViewStore.new]
    LogProcessor.process(full_path) do |resource, ip|
      stores.each { |store| store.record(resource, ip) }
    end

    output = stores.map do |store|
      PageViewsPresenter.new(store).generate_output
    end.join("\n\n")

    puts output
  end

  private

  def full_path
    @full_path ||= File.expand_path(path)
  end

  def validate_path!
    return if path.is_a?(String) && File.exist?(full_path) && !File.directory?(full_path)

    raise ArgumentError, 'Given path is not a valid filepath'
  end
end
