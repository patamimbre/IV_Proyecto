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
    let (:response) { get '/' }

    it "displays json test"

    it "returns status 200 OK" do
      last_response.status.to eql 200
    end
  end

  context "GET to /search/:id" do
    let (:response) { get '/search/CVE-2009-3800' }

    it "returns status 200 OK" do
      last_response.status.to eql 200
    end

    it "displays cve info"
  end

  context "GET to /yyyy/mm" do
    let (:response) { get '/2015/9' }

    it "returns status 200 OK" do
      last_response.status.to eql 200
    end

    it "displays all cves in a date"
  end


end