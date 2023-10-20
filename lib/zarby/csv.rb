# frozen_string_literal: true

module Zarby
  class NoColSepDetected < StandardError; end

  class Csv
    COMMON_DELIMITERS = ['","', '";"', '":"', '"|"'].freeze

    def initialize(content:)
      @content = content || ""
    end

    def self.detect_separator(content)
      new(content: content).detect_separator
    end

    def detect_separator
      valid? ? delimiters[0][0][1] : raise(Zarby::NoColSepDetected)
    end

    private

    def valid?
      !delimiters.collect(&:last).reduce(:+).zero?
    end

    # delimiters #=> [["\"|\"", 54], ["\",\"", 0], ["\";\"", 0]]
    # delimiters[0] #=> ["\";\"", 54]
    # delimiters[0][0] #=> "\",\""
    # delimiters[0][0][1] #=> ";"
    def delimiters
      @delimiters ||= COMMON_DELIMITERS.inject({}, &count).sort(&most_found)
    end

    def most_found
      ->(a, b) { b[1] <=> a[1] }
    end

    def count
      lambda { |hash, delimiter|
        hash[delimiter] = @content.count(delimiter)
        hash
      }
    end
  end
end
