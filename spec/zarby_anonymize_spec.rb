# encoding: utf-8

require "zarby"

describe Zarby do
  describe "Anonymize" do
    matcher :call_anonymize do |outpout|
      match do |result|
        expect(result).to eq(outpout)
      end
    end

    context 'render anonymization by default if the character string is less than 3' do
      subject { Zarby.anonymize "" }
      it { is_expected.to call_anonymize "**" }

      subject { Zarby.anonymize "z" }
      it { is_expected.to call_anonymize "**" }

      subject { Zarby.anonymize "za" }
      it { is_expected.to call_anonymize "**" }
    end

    context 'set one * by default if string size equal 4' do
      subject { Zarby.anonymize "mew" }
      it { is_expected.to call_anonymize "m*w" }
    end

    context 'set one * between two first and twho last char'  do
      subject { Zarby.anonymize "mewtwo" }
      it { is_expected.to call_anonymize "me**wo" }
    end

    context 'set one * between two first and twho last char split by "@"'  do
      subject { Zarby.anonymize "ectoplasma@mymail.com" }
      it { is_expected.to call_anonymize "ec******ma@my******om" }
    end
  end
end