# frozen_string_literal: true

module Zarby
  # this class is used to anonymize string on replace char with *
  class Anonymize
    def initialize(input: , nb_chars: 2, mask_with: '*')
      @input = input
      @nb_chars = nb_chars
      @mask_with = mask_with

      valid?
    end

    # @return [String]
    def call

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

    def valid?
      raise Zarby::ArgumentZarby, "input to anonymized must be of type String, #{@input.class} given" unless @input.is_a?(String)
      raise Zarby::ArgumentZarby, "mask_with to replace char must be of type String, #{@input.class} given" unless @mask_with.is_a?(String)
      raise Zarby::ArgumentZarby, "nb_chars must be greater then or equal to zero" if @nb_chars.negative?
    end
  end
end
