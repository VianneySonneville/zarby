# encoding: utf-8

require "zarby"

describe Zarby do
  describe "Normalize" do
    matcher :convert_to_utf8 do |output|
      match do |subject|
        result = subject.utf8

        expect(result.encoding.name).to eq('UTF-8')
        expect(result).to eq(output)
      end
    end

    context 'return "" if input is nil' do
      subject { Zarby::Normalize.new(input: nil) }
      it { is_expected.to convert_to_utf8('') }
    end

    context 'convert UTF-8 string' do
      subject { Zarby::Normalize.new(input: 'AaüAaß') }
      it { is_expected.to convert_to_utf8('AaüAaß') }
    end

    context 'convert with non-UTF-8 encoding' do
      subject { Zarby::Normalize.new(input: "Aa\xFCAa\xDF".force_encoding('Windows-1252')) }
      it { is_expected.to convert_to_utf8('AaüAaß') }
    end

    context 'convert with incorrect encoding' do
      # todo not work, string convert must be AaüAaß not Aa�Aa�
      subject { Zarby::Normalize.new(input: "Aa\xFCAa\xDF".force_encoding('ASCII-8BIT')) } # actually Windows-1252
      it { is_expected.to convert_to_utf8('Aa�Aa�') }
    end

    context 'convert with invalid characters' do
      subject { Zarby::Normalize.new(input: "Aa\x80Aa\x81".force_encoding('ASCII-8BIT')) } # never valid
      it { is_expected.to convert_to_utf8('Aa�Aa�') }
    end
  end
end