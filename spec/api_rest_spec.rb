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

    it "returns status 200 OK" do
      get '/'
      expect(last_response).to be_ok
    end
  end

  context "GET to /search/:id" do

    it "returns status 200 OK" do
      get '/search/CVE-2009-3800'
      expect(last_response).to be_ok
    end

    it "displays cve info"
  end

  context "GET to /service/:service" do

    it "returns status 200 OK" do
      get '/service/asd'
      expect(last_response).to be_ok
    end

    it "displays cves of service"
  end


end