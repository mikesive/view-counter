# frozen_string_literal: true

module FixtureHelper
  class << self
    def load_visits
      File.readlines(path('log.txt')).map(&:split)
    end

    def path(filename)
      File.join('./spec/fixtures', filename)
    end
  end
end
