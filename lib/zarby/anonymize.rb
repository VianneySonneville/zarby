# frozen_string_literal: true

module Zarby
  # this class is used to anonymise string on replace char with *
  class Anonymize
    def initialize(input, nb_chars: 2, mask_with: '*')
      @input = input
      @nb_chars = nb_chars
      @mask_with = mask_with
    end

    # @return [String]
    def call
      raise ArgumentError, "nb_chars must be greater then or equal to zero" if @nb_chars.negative?

      @input.include?("@") ? with_comercial_at : with_default_chars(@input)
    end

    private

    # @param input [String]
    # @return [String]
    def with_default_chars(input)
      if input.length < 3
        "**"
      elsif input.length <= @nb_chars * 2
        @nb_chars -= 1
        with_default_chars(input)
      else
        input.sub(
          /\A(.{#{@nb_chars}})(.*)(.{#{@nb_chars}})\z/,
          "\\1#{@mask_with * (input.length - (@nb_chars * 2))}\\3"
        )
      end
    end

    # @return [String]
    def with_comercial_at
      @input.split("@").map{ |v| with_default_chars(v) }.join("@")
    end
  end
end
