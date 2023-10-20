# frozen_string_literal: true

module Zarby
  class Normalize
    def initialize(input:)
      @input = input
    end

    def self.utf8(input)
      new(input: input).utf8
    end

    def utf8
      output = input if input.encoding.name == 'UTF-8' && input.valid_encoding?

      output ||= convert { input.encode('UTF-8') } #converting from the string's given encoding
      output ||= convert { input.force_encoding('UTF-8') } #composed of utf-8 bytes while not using utf-8 encoding ?
      output ||= convert { input.encode('UTF-8', 'Windows-1252') } # interpreting input as Windows-1252 ?
      output ||= convert { input.encode('UTF-8', 'ASCII-8BIT') } # Add any extra conversions
      output ||= convert { input.encode('UTF-8', 'US-ASCII') } # Add any extra conversions
      output ||= convert { input.encode('UTF-8', invalid: :replace, undef: :replace) } #replace any unknown characters with a placeholder: �

      output
    end

    private

    def convert(&block)
      string = yield
      string if string.valid_encoding?
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError
      nil
    end
  end
end
