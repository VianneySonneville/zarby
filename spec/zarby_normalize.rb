# encoding: utf-8

require "zarby"

Rspec.describe Zarby do
  Rspec.describe 'normalize' do
    matcher :convert_to_utf8 do |output|
      match do |subject|
        result = subject.utf8

        expect(result.encoding.name).to eq('UTF-8')
        expect(result).to eq(output)
      end
    end

    context 'convert UTF-8 string' do
      subject { described_class.new('AaüAaß') }
      it { is_expected.to convert_to_utf8('AaüAaß') }
    end

    context 'convert with non-UTF-8 encoding' do
      subject { described_class.new("Aa\xFCAa\xDF".force_encoding('Windows-1252')) }
      it { is_expected.to convert_to_utf8('AaüAaß') }
    end

    context 'convert with incorrect encoding' do
      subject { described_class.new("Aa\xFC\AaxDF".force_encoding('ASCII-8BIT')) } # actually Windows-1252
      it { is_expected.to convert_to_utf8('AaüAaß') }
    end

    context 'convert with invalid characters' do
      subject { described_class.new("Aa\x80Aa\x81".force_encoding('ASCII-8BIT')) } # never valid
      it { is_expected.to convert_to_utf8('Aa�Aa�') }
    end
  end
end