require 'sinatra'
require 'json'

get '/' do
  {'status' => 'ok'}.to_json
end

get '/search/:id' do |id|
  if id !~ /\ACVE-\d{4}-\d{4}\z/
    {'status' => 'bad_id'}.to_json

  else

    # buscar cve en DB y devolver json
    "CVE -> #{id}"

  end
end

get '/service/:service' do |s|

  # buscar cves en db por nombre de servicio
  "Servicio -> #{s}"

end

