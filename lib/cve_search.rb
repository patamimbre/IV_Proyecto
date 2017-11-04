require 'nokogiri'
require 'open-uri'
require 'date'
require 'json'

class CVESearch

  def search_by_month(date)

    DateTime.parse date rescue nil

    url = 'https://nvd.nist.gov/vuln/full-listing/'+date.to_s
    doc = Nokogiri::HTML(open(url))

    cves = doc.css('span.col-md-2').css('a').to_a

    # A cada elemento de cves se le aplica el método text
    # => ["CVE-2009-1493", "CVE-2009-1494"]
    cves.map!(&:text)

    cves.map do |cve_id|
      search_by_id(cve_id)
    end


  end

  def search_by_id(cve_id)

    cve = {}

    url = "http://www.cvedetails.com/cve-details.php?cve_id="+cve_id
    doc = Nokogiri::HTML(open(url))

    begin
      if !doc.css('h1').empty?    # Algunos CVEs están en nvd.nist pero no en cvedetails

        cve[:id] = cve_id

        # CVSS Scores
        score_table = doc.css('table#cvssscorestable').css('td')
        cve[:score] = score_table.css('div.cvssbox')
        cve[:confidenciality] = score_table[1].css('span')[0]
        cve[:integrity] = score_table[2].css('span')[0]
        cve[:availability] = score_table[3].css('span')[0]
        cve[:complexity] = score_table[4].css('span')[0]
        cve[:authentication] = score_table[5].css('span')[0]
        cve[:gained_access] = score_table[6].css('span')[0]
        cve[:cve_type] = score_table[7].css('span')[0]
        cve[:cwe_id] = score_table[8].css('a')[0]

        # Extrae el texto
        cve.drop(1).each do |key,val|
          if val.nil?
            cve[key] = ""
          else
            cve[key] = val.text
          end
        end


        # Products Affected
        # => [ {:product_type, :verdor, :product, :version, :update} ]
        products = []
        product_table = doc.css('table#vulnprodstable').css('tr')

        # Recorrer todos los tr (excepto el primero)
        product_table.drop(1).each do |p|
          a_product = {}
          p = p.css('td')
          a_product[:product_type] = p[1]
          a_product[:vendor] = p[2]
          a_product[:product] = p[3]
          a_product[:version] = p[4]
          a_product[:update] = p[5]
          a_product[:edition] = p[6]


          # Extrae el texto
          a_product.each do |key,val|
            if val.nil?
              a_product[key] = ""
            else
              un_val = val.text.lstrip.rstrip #elimina los espacios en blanco al principio y al final
              un_val = un_val.downcase.gsub(' ','-')
              a_product[key] = un_val
            end
          end

          products << a_product

        end

        cve[:products] = products

        cve
        # => {:name=>"CVE-1234-1234"
        #     :score=>"4.0",
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
    rescue Exception => e
      puts e
    end
  end



end

#cve = CVESearch.new
#puts cve.search_by_id('CVE-2013-3204').to_json
#puts cve.search_by_month('2009/6')
