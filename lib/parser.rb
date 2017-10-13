require 'nmap/xml'
require 'json'

Host = Struct.new(:IP, :os)
Service = Struct.new(:name, :product, :version, :port, :protocol, :info)

class String
  def red; colorize(self, "\e[1m\e[31m"); end
  def green; colorize(self, "\e[1m\e[32m"); end
  def dark_green; colorize(self, "\e[32m"); end
  def yellow; colorize(self, "\e[1m\e[33m"); end
  def blue; colorize(self, "\e[1m\e[34m"); end
  def dark_blue; colorize(self, "\e[34m"); end
  def purple; colorize(self, "\e[35m"); end
  def dark_purple; colorize(self, "\e[1;35m"); end
  def cyan; colorize(self, "\e[1;36m"); end
  def dark_cyan; colorize(self, "\e[36m"); end
  def pure; colorize(self, "\e[0m\e[28m"); end
  def bold; colorize(self, "\e[1m"); end
  def colorize(text, color_code) "#{color_code}#{text}\e[0m" end
end


class Parser

	attr_reader :data_map

	def initialize(filename='../output/.scan_result.xml')
		@data_map = {}
		parse(filename)
	end


	def to_json()
	end

	def print_output
		@data_map.each do |host, service_array|
			puts '·'.dark_blue.*45

			print "[#{host.IP}]::#{host.os}".red.bold
			service_array.each do |service|
				print "\n\t"
				service.each do |x|
					if x === service.first
						print x.to_s.yellow + " - "
					else	
						print x.to_s.green + " - "
					end
				end
			end
		end
		puts "\n" + '·'.dark_blue*45
	end

	def to_s
		@data_map.to_s
	end

	def to_array

	end

	private

	def parse(file)

		Nmap::XML.new(file) do |xml|
			xml.each_up_host do |host|
				
				# [IP, OS]
				a_host = Host.new(host.ip, host.os.matches.first.to_s)
				services = []

				host.each_port do |port|
						# [nombre, version, puerto, protocolo, info]
						a_service = Service.new(port.service.name,
												port.service.product,
												port.service.version,
												port.number,
												port.protocol,
												port.service.extra_info )
						services << a_service
				end

				@data_map[a_host] = services

			end
		end
		@data_map
	end 


end
