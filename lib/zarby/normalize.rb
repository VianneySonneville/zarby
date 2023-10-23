# frozen_string_literal: true

module Zarby
  class Normalize
    # utf-8 converting from the string's given encoding
    COMMON_ENCODINGS = %w[UTF-8 Windows-1252 ASCII-8BIT US-ASCII].freeze

    def initialize(input:)
      @input = input || ""
    end

    def self.utf8(input)
      new(input: input).utf8
    end

    def utf8
      output = @input if valid?
      COMMON_ENCODINGS.each do |encoding|
        output ||= convert { @input.encode(encoding) }
        output ||= convert { @input.force_encoding('UTF-8') } if encoding == 'UTF-8'
        puts output
      end

      output ||= unpack_pack { @input.unpack("C*").pack("U*") } if output.nil?

      # replace any unknown characters with a placeholder: �
      output ||= convert { @input.encode('UTF-8', invalid: :replace, undef: :replace) }
      puts output
      output
    end

    private

    def convert
      string = yield
      string if string.valid_encoding?
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError
      nil
    end

    def unpack_pack
      string = yield
      string if string.valid_encoding?
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError
      nil
    end

    def valid?
      @input.encoding.name == 'UTF-8' && @input.valid_encoding?
    end
  end
end
