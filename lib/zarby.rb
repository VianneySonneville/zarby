# frozen_string_literal: true

require_relative 'zarby/version'
require_relative 'zarby/csv'
require_relative 'zarby/normalize'
require_relative 'zarby/anonymize'

module Zarby
  def anonymise(input, nb_chars: 2, mask_with: '*')
    Anonymize.new(input:, nb_chars: nb_chars, mask_with: mask_with).call
  end

  def detect_separator(content)
    Csv.new(content:).call
  end

  def utf8(input)
    Normalize.new(input:).call
  end

  module_function :anonymise, :detect_separator, :utf8 
  private_constant :Anonymize
end
