# frozen_string_literal: true

require_relative 'zarby/version'
require_relative 'zarby/csv'
require_relative 'zarby/normalize'
require_relative 'zarby/anonymize'

module Zarby
  class ZarbyError < StandardError; end

  def utf8(input)
    Normalize.utf8(input)
  end
  module_function :utf8

  def detect_separator(_content)
    Csv.detect_separator(input)
  end
  module_function :detect_separator

  def anonymise(input, nb_chars: 2, mask_with: '*')
    Zarby::Anonymize.new(input, nb_chars: nb_chars, mask_with: mask_with).call
  end

  module_function :anonymise
end
