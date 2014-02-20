 namespace :sms do
  
  desc "send sms"

class SampleGateway
  
  # MT id counter. 
    @@mt_id = 0
    
    # expose SMPP transceiver's send_mt method
    def self.send_mt(*args)
      @@mt_id += 1
      @@tx.send_mt(@@mt_id, *args)
    end
      
    def logger
      Smpp::Base.logger
    end

    def start(config)
      # The transceiver sends MT messages to the SMSC. It needs a storage with Hash-like
      # semantics to map SMSC message IDs to your own message IDs.
      pdr_storage = {} 

      # Run EventMachine in loop so we can reconnect when the SMSC drops our connection.
      puts "Connecting to SMSC..."
      loop do
        EventMachine::run do             
          @@tx = EventMachine::connect(
            config[:host], 
            config[:port], 
            Smpp::Transceiver, 
            config, 
            self    # delegate that will receive callbacks on MOs and DRs and other events
          )     
#          print "MT: "
#          $stdout.flush
          
          # Start consuming MT messages (in this case, from the console)
          # Normally, you'd hook this up to a message queue such as Starling
          # or ActiveMQ via STOMP.
#          EventMachine::open_keyboard(KeyboardHandler)
        end
        puts "Disconnected. Reconnecting in 5 seconds.."
        sleep 5
      end
    end
    
    # ruby-smpp delegate methods 
    def kickhoat (body)
    		
    end

    def mo_received (transceiver, pdu)
      logger.info "Delegate: mo_received: from #{pdu.source_addr} to #{pdu.destination_addr}: #{pdu.short_message}"
	  
    sms = Smsdb.new
    sms.sdt = pdu.source_addr.to_s
    sms.message = pdu.short_message.to_s
    body = pdu.short_message.downcase.to_s[3..-1]
    
    if ((body =~ /^[a-zA-Z0-9]{6}$/).nil?)
  	puts "check"
	  mess = "Ma chung thuc khong dung.Ma bao gom 6 ky tu A-Z,0-9,khong co dau cach va ky tu dac biet.Lien he tong dai 19006609 de duoc ho tro"
  	SampleGateway.send_mt(pdu.destination_addr, pdu.source_addr, "Ma chung thuc bao gom 6 ky tu A-Z,0-9. Lien he tong dai 19006609 de duoc ho tro")	
	  sms.error = "1"
    return
   	end
	puts "checknot"
  	p = PrintManager.where("codegen_name=?",body).first
  	
	if(p.nil?)
  		SampleGateway.send_mt(pdu.destination_addr,pdu.source_addr, ErrorMessage.find(2).message.to_s)
      sms.error = "2"
      sms.save
  		return

  else
    if p.package.captem.nil?
      SampleGateway.send_mt(pdu.destination_addr,pdu.source_addr, ErrorMessage.find(2).message.to_s)
      sms.error = "2"
      sms.save
      return
    else
      if p.package.captem.phattem.nil?
        SampleGateway.send_mt(pdu.destination_addr,pdu.source_addr, ErrorMessage.find(2).message.to_s)
        sms.error = "2"
        sms.save
        return
      else
        if(p.package.ptype_id.to_s == '5' && pdu.destination_addr.to_s == '8137')
          SampleGateway.send_mt(pdu.destination_addr,pdu.source_addr,ErrorMessage.find(3).message.to_s)
          sms.error = "3"
          sms.save
          return
        end
        if (p.kh.to_i > 0)
          string = "#{p.package.captem.phattem.san_pham.sp_tat} do #{p.package.captem.phattem.san_pham.doanh_nghiep.dn_tat} dang ki chung thuc vao #{p.package.captem.phattem.approve_at.strftime("%d-%m-%Y")}. #{p.codegen_name} da duoc truy van #{p.kh} lan"
        puts string  
	SampleGateway.send_mt(pdu.destination_addr,pdu.source_addr, string.to_s)
        puts p.kh  
	p.kh = p.kh.next
          p.save
          sms.error = "4"
          sms.print_manager = p
          sms.save
          return
        end
        
        strings = "#{p.package.captem.phattem.san_pham.sp_tat} do #{p.package.captem.phattem.san_pham.doanh_nghiep.dn_tat} dang ki chung thuc vao #{p.package.captem.phattem.approve_at.strftime("%d-%m-%Y")}, #{p.package.captem.phattem.san_pham.giay_phep} " + ErrorMessage.find(5).message.to_s
	puts strings
        SampleGateway.send_mt(pdu.destination_addr,pdu.source_addr,strings.to_s)
        sms.print_manager = p
        sms.error = "5"
        sms.save
	puts p.kh
        p.kh = p.kh.next
        p.save
    

      end  
    end
  end

  	
  	
    end

    def delivery_report_received(transceiver, pdu)
      logger.info "Delegate: delivery_report_received: ref #{pdu.msg_reference} stat #{pdu.stat}"
    end

    def message_accepted(transceiver, mt_message_id, pdu)
      logger.info "Delegate: message_accepted: id #{mt_message_id} smsc ref id: #{pdu.message_id}"
    end

    def message_rejected(transceiver, mt_message_id, pdu)
      logger.info "Delegate: message_rejected: id #{mt_message_id} smsc ref id: #{pdu.message_id}"
    end

    def bound(transceiver)
      logger.info "Delegate: transceiver bound"
    end

    def unbound(transceiver)  
      logger.info "Delegate: transceiver unbound"
      EventMachine::stop_event_loop
    end
    
end

  task :sms_run => :environment do
  	#require 'rubygems'
	#gem 'ryby-gems'
	#require File.dirname(__FILE__) + '/../.rvm/gems/ruby-1.9.3-p448/gems/ruby-smpp-0.6.0/lib/smpp'
  	require '~/.rvm/gems/ruby-1.9.3-p448/gems/ruby-smpp-0.6.0/lib/smpp'
	LOGFILE = File.dirname(__FILE__) + "/sms_gateway.log"
  	#require  './smpp'
	Smpp::Base.logger = Logger.new(LOGFILE)
  	
  config = {
    :host => '10.19.1.12',
    :port => 8888,
    :system_id => 'temsms',
    :password => 'dlUx3gT5',
    :system_type => '', # default given according to SMPP 3.4 Spec
    :interface_version => 52,
    :source_ton  => 0,
    :source_npi => 1,
    :destination_ton => 1,
    :destination_npi => 1,
    :source_address_range => '',
    :destination_address_range => '',
    :enquire_link_delay_secs => 10
  }  
  gw = SampleGateway.new
  gw.start(config)  
end

  desc "TODO"
  task :create => :environment do
  end

end
