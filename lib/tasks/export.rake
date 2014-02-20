namespace :export do
  desc "TODO"
  task :csv => :environment do
	num_lo = ENV['NUM']
	lo_type = ENV['TYPE']
	num = num_lo.to_i
	require 'csv'
	file_name = ENV['FILE']
	
	#Check so luong lo.
	packages = Package.where("ptype_id=?",lo_type)
	if (packages.count < num_lo.to_i)		
		puts "Helloworld"
	else
		num = num - 1
		CSV.open(file_name, 'w') do |csv|
			csv << ["In lo va pin"]
			(0..num).each do |t|
				p = packages[t].name
				prints = PrintManager.where("package_id=?",p)
				string = p.to_s
				prints.each do |print|
					string = string + ',' +  print.codegen_id 
				end
				csv << string.parse_csv				
			end
		
		end
	end
  end



end
