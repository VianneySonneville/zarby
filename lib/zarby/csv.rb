# frozen_string_literal: true

module Zarby
  class NoColSepDetected < StandardError; end

  # this class is used to detect the column separator in a CSV file
  class Csv
    COMMON_DELIMITERS = ['","', '";"', '":"', '"|"'].freeze

    # @param [String] content
    # @return [Csv]
    def initialize(content:)
      @content = content || ""
    end

    # @param [String] content
    # @return [String]
    def self.detect_separator(content)
      new(content: content).detect_separator
    end

    # @return [String]
    def detect_separator
      valid? ? delimiters[0][0][1] : raise(Zarby::NoColSepDetected)
    end

    private

    # @return [Boolean]
    def valid?
      !delimiters.collect(&:last).reduce(:+).zero?
    end

    # delimiters #=> [["\"|\"", 54], ["\",\"", 0], ["\";\"", 0]]
    # delimiters[0] #=> ["\";\"", 54]
    # delimiters[0][0] #=> "\",\""
    # delimiters[0][0][1] #=> ";"
    # @return [Array<Array<String, Integer>>]
    def delimiters
      @delimiters ||= COMMON_DELIMITERS.inject({}, &count).sort(&most_found)
    end

    # @return [Proc]
    def most_found
      ->(a, b) { b[1] <=> a[1] }
    end

    # @return [Proc]
    def count
      lambda { |hash, delimiter|
        hash[delimiter] = @content.count(delimiter)
        hash
      }
    end
  end
end
