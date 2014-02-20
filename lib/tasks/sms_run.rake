namespace :sms_run do
  desc "TODO"
 task :work => :environment do
	require "./sample_gateway.rb"
	ruby sample_gateway.rb 
 end

 task :run => :environment do
  	require "./sample_gateway.rb"
	
	config = {
    	:host => '10.19.1.12', 
	:port => 8888, 
    	:system_id => 'temsms', 
	:password => 'dlUx3gT5', 
	:system_type => '', 
    	:interface_version => 52,
    	:source_ton => 0, source_npi => 1, 
    	:destination_ton => 1, 
	:destination_npi => 1, 
   	:source_address_range => '', 
    	:destination_address_range => '', 
    	:enquire_link_delay_secs => 10
   	}
	gw = SampleGateway.new
	#SampleGateway.work
	gw.start(config)
	#p = Popsms.new
	
  end

end
