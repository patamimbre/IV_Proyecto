require 'socket'
require 'nmap/program'



class Scanner
	def self.localIP
		UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
	end

	def self.LocalSubnet
		localIP.split(".")[0..2].push(0).join(".")
	end

	def self.scan(target='all') 
		if target.eql? 'all'
			target = subnetscan
		end

		puts "Target: #{target}"

		Nmap::Program.sudo_scan do |nmap|

		  #puede ser '192.168.0.*' ... encontrar ip de red
		  # Target
		  nmap.targets = target

		  # Debugging
		  nmap.verbose = true
		  nmap.show_reason = false

		  # Port scanning
		  nmap.syn_scan = true
		  nmap.all = true    ## -A en nmap

		  # Service/Version detection
		  nmap.service_scan = true
		  nmap.os_fingerprint = true
		  nmap.version_all = true

		  # Script scanning
		  # https://nmap.org/book/nse-usage.html#nse-categories
		  # nmap.script = "all"
		  # nmap.script = "discovery"

		  # Ports
		  nmap.all_ports    # nmap.ports = (0..65535).to_a

		  # Firewall/IDS Evasion
		  nmap.decoys = ["google.com","yahoo.com","hotmail.com","facebook.com"]

		  # Spoofing
		  # nmap.spoof_mac = "00:11:22:33:44:55"

		  # Timing and Performance
		  nmap.min_parallelism = 30
		  nmap.max_parallelism = 130

		  # Scan outputs
		  nmap.output_all = './output/.scan_result'
		end
	end

	private
	def subnetscan
		localIP.split(".")[0..2].push('*').join(".")
	end



end
