# frozen_string_literal: true

module Zarby
  # this class is used to normalize the input string to UTF-8
  class Normalize
    extend Gem::Deprecate

    # utf-8 converting from the string's given encoding
    COMMON_ENCODINGS = %w[UTF-8 Windows-1252 ASCII-8BIT ISO-8859-1 US-ASCII].freeze

    # @param input [String]
    # @return [String]
    def initialize(input:)
      raise Zarby::ArgumentZarby, "input to normalise utf8 must be of type String, #{input.class} given" unless input.is_a?(String)
      @input = input&.force_encoding(Encoding::UTF_8) || ''
    end

    # @return [String]
    def call
      output = @input if valid?


      output ||= @input.force_encoding(Encoding::ISO_8859_1).encode!(Encoding::UTF_8)
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError
      raise
    end

    # @return [String]
    def utf8
      output = @input if valid?


      output ||= @input.force_encoding(Encoding::ISO_8859_1).encode!(Encoding::UTF_8)
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError
      nil
    end
    deprecate :utf8, 'Zarby#utf8(.string)', 2024, 10

    class << self
      # @param input [String]
      # @return [String]
      def utf8(input)
        new(input: input).utf8
      end
    end

    private

    # @return [Boolean]
    def valid?
      @input.encoding.name == 'UTF-8' && @input.valid_encoding?
    end
  end
end
