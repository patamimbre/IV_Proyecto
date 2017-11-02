require 'nokogiri'
require 'open-uri'
require 'json'

# Vulnerabilidades a partir de 2002

# fecha => 2009/4
def search_cves(fecha)
  url = 'https://nvd.nist.gov/vuln/full-listing/'+fecha
  doc = Nokogiri::HTML(open(url))

  cves = doc.css('span.col-md-2').css('a').to_a

  # A cada elemento de cves se le aplica el método text
  cves.map(&:text)
  # => ["CVE-2009-1493", "CVE-2009-1494"]
end

def parse_cve(cve_id)

  cve = {}

  url = "http://www.cvedetails.com/cve-details.php?cve_id="+cve_id
  doc = Nokogiri::HTML(open(url))

  # CVSS Scores
  score_table = doc.css('table#cvssscorestable').css('td')
  cve[:score] = score_table.css('div.cvssbox').text
  cve[:confidenciality] = score_table[1].css('span')[0].text
  cve[:integrity] = score_table[2].css('span')[0].text
  cve[:availability] = score_table[3].css('span')[0].text
  cve[:complexity] = score_table[4].css('span')[0].text
  cve[:authentication] = score_table[5].css('span')[0].text
  cve[:gained_access] = score_table[6].css('span')[0].text
  cve[:cve_type] = score_table[7].css('span')[0].text
  cve[:cwe_id] = score_table[8].css('a')[0].text

  # Products Affected
  # => [ {:product_type, :verdor, :product, :version, :update} ]
  products = []
  product_table = doc.css('table#vulnprodstable').css('tr')

  # Recorrer todos los tr (excepto el primero)
  product_table.drop(1).each do |p|
    a_product = {}
    p = p.css('td')
    a_product[:product_type] = p[1].text.strip
    a_product[:vendor] = p[2].text.strip
    a_product[:product] = p[3].text.strip
    a_product[:version] = p[4].text.strip
    a_product[:update] = p[5].text.strip
    a_product[:edition] = p[6].text.strip
    products << a_product
  end

  cve[:products] = products

  cve
  # => {:score=>"4.0",
  #     :confidenciality=>"None",
  #     :integrity=>"None",
  #     :availability=>"Partial",
  #     :complexity=>"Low",
  #     :authentication=>"Single system",
  #     :gained_access=>"None",
  #     :cve_type=>"Denial Of Service",
  #     :cwe_id=>"20",
  #     :products=>[{:product_type=>"OS", :vendor=>"Fortinet", :product=>"Fortios", :version=>"5.4.0", :update=>"", :edition=>""},
  #                 {:product_type=>"OS", :vendor=>"Fortinet", :product=>"Fortios", :version=>"5.4.1", :update=>"", :edition=>""},
  #                 {:product_type=>"OS", :vendor=>"Fortinet", :product=>"Fortios", :version=>"5.4.3", :update=>"", :edition=>""},
  #                 {:product_type=>"OS", :vendor=>"Fortinet", :product=>"Fortios", :version=>"5.4.4", :update=>"", :edition=>""},
  #                ]
  #    }

end







#cve_array = search_cves('2009/4')
#puts cve_array.to_s

a_cve = parse_cve("CVE-2017-14182")
eljson = a_cve.to_json

c = JSON.parse(eljson)

c.each { |x| puts x}
