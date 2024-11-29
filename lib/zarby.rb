
require_relative 'zarby/version'
require_relative 'zarby/csv'
require_relative 'zarby/normalize'
require_relative 'zarby/anonymize'
require_relative 'zarby/errors'

module Zarby
  # Anonymizes a given input by masking the first `nb_chars` characters with `mask_with`.
  #
  # @param input [String] The string input to be anonymized.
  # @param nb_chars [Integer] The number of characters from the input to be masked. Default is 2.
  # @param mask_with [String] The character to mask the input with. Default is '*'.
  # @return [String] The anonymized string with masked characters.
  def anonymize(input, nb_chars: 2, mask_with: '*')
    Anonymize.new(input:, nb_chars:, mask_with:).call
  end

  # Detects and returns the separator used in the provided CSV content.
  #
  # @param content [String] The CSV content to detect the separator for.
  # @return [String] The detected separator (e.g., ',' or ';').
  def detect_separator(content)
    Csv.new(content:).call
  end

  # Normalizes the input string to UTF-8 encoding.
  #
  # @param input [String] The input string to normalize.
  # @return [String] The normalized string in UTF-8 encoding.
  def utf8(input)
    Normalize.new(input:).call
  end

  # Expose methods as module functions for easy use without needing to instantiate.
  module_function :anonymize, :detect_separator, :utf8 

  # Prevents direct access to the Anonymize class outside the module.
  private_constant :Anonymize
end
