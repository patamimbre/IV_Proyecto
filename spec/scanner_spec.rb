require 'minitest/autorun'
require 'minitest/spec'

$:.unshift File.expand_path(File.dirname(__FILE__) + '/..')

require 'lib/scanner'

describe Scanner do 
  subject {Scanner}

  it "debe tener una ip local" do
    Scanner.must_respond_to 'localIP'
  end

  it "debe estar conectado a una subred" do
    Scanner.must_respond_to 'LocalSubnet'
  end

  describe '#scan' do
    it "responde al método scan" do
      Scanner.must_respond_to 'scan'
    end
  end

end