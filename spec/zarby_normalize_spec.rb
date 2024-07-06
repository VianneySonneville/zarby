# encoding: utf-8

require "zarby"

describe Zarby do
  describe "Normalize" do
    matcher :convert_to_utf8 do |output|
      match do |result|
        expect(result.encoding.name).to eq('UTF-8')
        expect(result).to eq(output)
      end
    end

    context 'convert UTF-8 string' do
      subject { Zarby.utf8('AaüAaß') }
      it { is_expected.to convert_to_utf8('AaüAaß') }
    end

    context 'convert with non-UTF-8 encoding' do
      subject { Zarby.utf8("Aa\xFCAa\xDF".force_encoding('Windows-1252')) }
      it { is_expected.to convert_to_utf8('AaüAaß') }
    end

    context 'convert with incorrect encoding' do
      subject { Zarby.utf8("Aa\xFCAa\xDF".force_encoding('ASCII-8BIT')) } # actually Windows-1252
      it { is_expected.to convert_to_utf8('AaüAaß') }
    end

    context 'convert with incorrect encoding' do
      subject { Zarby.utf8("Dur\xC3\xA9e".force_encoding('ASCII-8BIT')) } # actually Windows-1252
      it { is_expected.to convert_to_utf8('Durée') }
    end

    context 'convert invalid char' do
      subject { Zarby.utf8("Aa\x80Aa\x81".force_encoding('ASCII-8BIT')) }
      it { is_expected.to convert_to_utf8("Aa\u0080Aa\u0081") }
    end

    context "must return exception if content not be a String" do
      it do
        expect(Zarby.utf8(nil))
        rescue Zarby::ArgumentZarby => e
        expect(e).to be_a(Zarby::ArgumentZarby)
      end
    end
  end
end