# frozen_string_literal: true

module Zarby
  class Normalize
    # utf-8 converting from the string's given encoding
    COMMON_ENCODINGS = %w[UTF-8 Windows-1252 ASCII-8BIT ISO-8859-1 US-ASCII].freeze

    def initialize(input:)
      @input = input || ''
    end

    def self.utf8(input)
      new(input: input).utf8
    end

    def self.magic_utf8(input)
      new(input: input).magic_utf8
    end

    def utf8
      output = @input if valid?

      output ||= @input.force_encoding(Encoding::ISO_8859_1).encode!(Encoding::UTF_8)
    end

    private

    def valid?
      @input.encoding.name == 'UTF-8' && @input.valid_encoding?
    end
  end
end
