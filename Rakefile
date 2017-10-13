task default: %w[test]

task :test do
	ruby "spec/scanner_spec.rb"
	#ruby "spec/parser_spec.rb"
end

task :clean do 
	rm_rf "output"
end
