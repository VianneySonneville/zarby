# encoding: utf-8

require "zarby"
require "csv"

RSpec.describe Zarby do
  it "Can find delimiter demicolon in csv file" do
    expect(Zarby::Csv.detect_separator(File.read("#{__dir__}/semicolon.csv"))).to eq ";"
  end
  it "Can find delimiter double_point in csv file" do
    expect(Zarby::Csv.detect_separator(File.read("#{__dir__}/double_point.csv"))).to eq ":"
  end
  it "Can find delimiter pipe in csv file" do
    expect(Zarby::Csv.detect_separator(File.read("#{__dir__}/pipe.csv"))).to eq "|"
  end
  it "Can find delimiter comma in csv file" do
    expect(Zarby::Csv.detect_separator(File.read("#{__dir__}/comma.csv"))).to eq ","
  end
  it "must return exception if delimiter not found in COMMON_DELIMITERS" do
    puts expect(Zarby::Csv.detect_separator(File.read("#{__dir__}/error.csv")))
    rescue Zarby::NoColSepDetected => e
    expect(e).to be_a(Zarby::NoColSepDetected)
  end
end