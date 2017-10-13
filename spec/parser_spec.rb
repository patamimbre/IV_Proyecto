require 'minitest/autorun'
require 'minitest/spec'

$:.unshift File.expand_path(File.dirname(__FILE__) + '/..')

require 'lib/parser'

describe Parser do
  subject {Parser.new}

  it "debe ser instancia de Parser" do
    subject.must_be_instance_of Parser
  end

  it "debe tener un hash" do
    subject.must_respond_to 'data_map'
  end

  it "el hash debe estar vacío" do
    subject.data_map.must_be_instance_of Hash
    subject.data_map.must_be_empty
  end

  it "debe responder a print_output" do
    subject.must_respond_to 'print_output'
  end

  describe '#to_json' do
    it "debe responder al método" do
      subject.must_respond_to 'to_json'
    end

    #debe devolver un json

  end

end