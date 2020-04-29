# frozen_string_literal: true

# The LogProcessor class is meant purely to parse out
# the relevant details from each log line (resource, ip)
# and yield to whatever code it is passed.
class LogProcessor
  class << self
    def process(path)
      unless block_given?
        raise(ArgumentError, 'LogProcessor.process requires a block argument')
      end

      File.readlines(path).each do |line|
        resource, ip = line.split
        raise(ArgumentError, 'Bad formatting in log file') unless resource && ip

        yield resource, ip
      end
    end
  end
end
