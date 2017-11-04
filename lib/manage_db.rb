require_relative('cve_search.rb')
require 'faraday'
require 'faraday_middleware'
require 'json'
require 'logger'

# https://blog.diacode.com/peticiones-http-de-manera-sencilla-con-faraday







class DBmanager

  def initialize (url_api)
    @cve_search = CVESearch.new

    @conn = Faraday.new(url: url_api) do |faraday|
      #faraday.response :logger, ::Logger.new(STDOUT), bodies: true                  # Loggea las respuestas por STDOUT
      faraday.response :json
      faraday.request :json                     # Peticiones en JSON
      faraday.use Faraday::Adapter::NetHttp     # Usa el adaptador por defecto
      faraday.use FaradayMiddleware::ParseJson  # Middleware para parsear respuestas a JSON
    end
  end

  def add_cve(cve_id)
    cve_json = @cve_search.search_by_id(cve_id).to_json

    response = @conn.post do |req|                         # método post
      req.url '/api/insert'                               # url de la petición
      req.headers['Content-Type'] = 'application/json'    # cabecera

      # Se crea el cuerpo del mensaje
      req_body = cve_json

      req.body = req_body
    end
  end

  def search_cve(service,version)

    cve_response = @conn.post("/api/search/#{service}/#{version.to_s}")
    cve_response.body

  end
end

url_api = 'https://frozen-everglades-36730.herokuapp.com'
service="internet-explorer"
version = '7'

db = DBmanager.new(url_api)
puts db.search_cve(service,version)

