require_relative 'scanner.rb'
require_relative 'parser.rb'

ip = ARGV[0]
ip ='127.0.0.1' if ARGV.empty?
#Scanner.scan(ip)
parseador = Parser.new()
parseador.print_output
