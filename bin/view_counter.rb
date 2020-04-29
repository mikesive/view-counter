#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative '../lib/app_runner'

unless (path = ARGV.first)
  raise ArgumentError, 'Please provide a path to your logfile'
end

AppRunner.new(path).run
