# spec/api_rest_spec.rb

require 'rspec'
require 'rack/test'
require File.expand_path '../../lib/api_rest.rb', __FILE__

describe "API REST" do

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "GET to /" do
    it "displays json test"
  end

  context "GET to /search/:id" do
    it "returns status 200 OK"
    it "displays cve info"
    it "display incorrect cve"
  end

  context "GET to /yyyy/mm" do
    it "returns status 200 OK"
    it "displays all cves in a date"
    it "display incorrect date"
  end


end