# # encoding: utf-8

require "zarby"

describe Zarby do
  describe "Csv" do
    context "raise error if content is nil" do
      it do
        expect(Zarby.detect_separator(nil))
        rescue Zarby::ColSeparatorZarby => e
        expect(e).to be_a(Zarby::ColSeparatorZarby)
      end
    end
    context "Can find delimiter demicolon in csv file" do
      subject { Zarby.detect_separator(File.read("#{__dir__}/semicolon.csv")) }
      it { is_expected.to eq ";" }
    end
    context "Can find delimiter double_point in csv file" do
      subject { Zarby.detect_separator(File.read("#{__dir__}/double_point.csv")) }
      it { is_expected.to eq ":" }
    end
    context "Can find delimiter pipe in csv file" do
      subject { Zarby.detect_separator(File.read("#{__dir__}/pipe.csv")) }
      it { is_expected.to eq "|" }
    end
    context "Can find delimiter comma in csv file" do
      subject { Zarby.detect_separator(File.read("#{__dir__}/comma.csv")) }
      it { is_expected.to eq "," }
    end

    context "must return exception if delimiter not found in COMMON_DELIMITERS" do
      it do
        expect(Zarby.detect_separator(File.read("#{__dir__}/error.csv")))
        rescue Zarby::ColSeparatorZarby => e
        expect(e).to be_a(Zarby::ColSeparatorZarby)
      end
    end
  end
end