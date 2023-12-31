# # encoding: utf-8

require "zarby"
require "csv"

describe Zarby do
  describe "Csv" do
    context "raise error if content is nil" do
      it do
        expect(Zarby::Csv.detect_separator(nil))
        rescue Zarby::NoColSepDetected => e
        expect(e).to be_a(Zarby::NoColSepDetected)
      end
    end
    context "Can find delimiter demicolon in csv file" do
      subject { Zarby::Csv.detect_separator(File.read("#{__dir__}/semicolon.csv")) }
      it { is_expected.to eq ";" }
    end
    context "Can find delimiter double_point in csv file" do
      subject { Zarby::Csv.detect_separator(File.read("#{__dir__}/double_point.csv")) }
      it { is_expected.to eq ":" }
    end
    context "Can find delimiter pipe in csv file" do
      subject { Zarby::Csv.detect_separator(File.read("#{__dir__}/pipe.csv")) }
      it { is_expected.to eq "|" }
    end
    context "Can find delimiter comma in csv file" do
      subject { Zarby::Csv.detect_separator(File.read("#{__dir__}/comma.csv")) }
      it { is_expected.to eq "," }
    end

    context "must return exception if delimiter not found in COMMON_DELIMITERS" do
      it do
        expect(Zarby::Csv.detect_separator(File.read("#{__dir__}/error.csv")))
        rescue Zarby::NoColSepDetected => e
        expect(e).to be_a(Zarby::NoColSepDetected)
      end
    end
  end
end