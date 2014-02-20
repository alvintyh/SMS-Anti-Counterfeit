namespace :redis_sql do
  
  task :initialize => [:create_lo_type,  :init_mess, :create_user] do
    #:test_s_d, :test_d,
    puts "Hello"
    #AdminUser.first.add_role "admin"
  end
  desc "Generate Error Message"
  task :init_mess => :environment do
	mess = ErrorMessage.new
	mess.message = "Ma chung thuc san pham khong chinh xac. Ma dung bao gom 7 ky tu A-Z, 0-9, khong bao gom dau cach va ky tu dac biet. Lien he tong dai 19006609 de duoc ho tro"
  mess.save
	mess1 = ErrorMessage.new
	mess1.message = "Ma chung thuc san pham chua duoc kick hoat. De duoc tu van them, vui long lien he tong dai 19006609"
	mess1.save
	mess2 = ErrorMessage.new
	mess2.message = "Ban gui sai tong dai, mat hang nay yeu cau gui den 8537"
	mess2.save
	mess3 = ErrorMessage.new
	mess3.message = ""
  mess3.save
	mess4 = ErrorMessage.new
	mess4.message = " do Vien VSATTP cap phep"
 	mess4.save
  end	  

  task :create_user => :environment do
      mod = AdminUser.find(2)
      daily1 = DaiLy.new
      daily1.name = "Dai Ly Hoan Kiem"
      daily1.admin_user = mod
      daily1.save

      dn1 = DoanhNghiep.new
      dn1.name = "Sony"
      dn1.dai_ly = daily1
      dn1.admin_user = AdminUser.find(4)
      dn1.save


      sp = SanPham.new
      sp.name = "Sony Laptop"
      sp.doanh_nghiep = dn1
      sp.save

      sp = SanPham.new
      sp.name = "Sony Smartphone"
      sp.doanh_nghiep = dn1
      sp.save

      sp = SanPham.new
      sp.name = "Sony TV"
      sp.doanh_nghiep = dn1
      sp.save
      
      
      mod1 = AdminUser.find(3)
      daily2 = DaiLy.new
      daily2.name = "Dai Ly Cau Giay"
      daily2.admin_user = mod1
      daily2.save

      dn2 = DoanhNghiep.new
      dn2.name = "Samsung"
      dn2.dai_ly = daily2
      dn2.admin_user = AdminUser.find(5)
      dn2.save

      sp = SanPham.new
      sp.name = "Samsung Laptop"
      sp.doanh_nghiep = dn2
      sp.save

      sp = SanPham.new
      sp.name = "Samsung Laptop"
      sp.doanh_nghiep = dn2
      sp.save

      sp = SanPham.new
      sp.name = "Samsung Laptop"
      sp.doanh_nghiep = dn2
      sp.save
      

  end


  desc "Generate pin code and lo code store in 'pin' redis db 50 instance"
  task :run_gen => :environment do
  	require "./generatekey.rb"  
    gg = Generatekey.new("maaaaa")
    gg.generate_code(50000,"pincode")
    #puts gg.shorturl
    File.open("value.txt", "w") do |w|
        w.write gg.shorturl
    end
  end

  desc "get package out to phat_tem db"
  task :tem_dn => :environment do
    lo_num = ENV['N']
    sp = ENV['S']
    admin_id = ENV['A']
    
    DaiLyQuanLy.limit(lo_num.to_i).each do |t|
      pt = PhatTem.new
      pt.dai_ly_quan_ly = t
      pt.PIN = t.print_manager.codegen_id
      pt.Lo = t.print_manager.package_id
      pt.tem_type = t.print_manager.ptype
      pt.lo_status = t.print_manager.printed
      pt.san_pham = SanPham.where("id=?", sp.to_s).first
      pt.doanh_nghiep_id = pt.san_pham.doanh_nghiep.id
      pt.admin_user_id = admin_id
      pt.save
    end
  end

  task :phattem => :environment do
    id = ENV["I"]
    #so_luong = ENV["N"]
    date = DateTime.now
    yeucau = DangkiPhattem.find(id.to_i)
    yeucau.approve = 1
    yeucau.approve_at = date
    yeucau.save
    Captem.where(:issued => 1).limit(yeucau.luong_lo.to_i).each do |t|
      #t.san_pham = yeucau.san_pham
      t.issued = 2
      t.save

    phat = Phattem.new
    phat.san_pham = yeucau.san_pham
    phat.captem = t
    phat.approve_at = date
    phat.save
    end
  end

  task :captem => :environment do
     id = ENV["I"]
    date = DateTime.now
     yeucau = DangkiCaptem.find(id.to_i)
     yeucau.approve = 1
     yeucau.aprove_at = date
     yeucau.save
     Package.where(:issued => 0).limit(yeucau.luong_lo.to_i).each do |t|
       t.issued = 1
       t.save

     cap = Captem.new
     cap.dai_ly = yeucau.dai_ly
     cap.package = t
     cap.issued = 1
     cap.aprove_at = date
     cap.save

     end



  end


  #Post.where(author: author)  Author.joins(:posts).where(posts: {author: author})
    desc "get package out to quan ly db"
  task :tem_dl => :environment do
    loai_lo = ENV['L']
    sp = ENV['S']
    so_luong_lo = ENV['N']
    admin_id = ENV['A']
    # so luong lo = 5 

    #Package.where(ptype_id: 'loai_lo').each do |t|
    PrintManager.where(:ptype => loai_lo, :printed => "1").limit(so_luong_lo.to_i).each do |t|
      #(1..so_luong_lo.to_i).each do
        dlql = DaiLyQuanLy.new
        dlql.print_manager = t
        dlql.dai_ly = DaiLy.where("id=?", sp.to_i).first
        t.printed = "2"
        t.save
        dlql.admin_user_id = admin_id
        dlql.save
        
      #end
    end
    
  end

  desc "test creat dai ly"
  task :test_d => :environment do
    (1..10).each do |i|
      dn = DaiLy.new
      dn.name = "dai ly " + i.to_s
      dn.save
    end
  end
  
  desc "test creat san pham va doanh nghiep"
  task :test_s_d => :environment do
    (1..10).each do |i|
      dn = DoanhNghiep.new
      dn.name = "doanh nghiep" + i.to_s
      dn.save
      (1..3).each do |j|
        sp = SanPham.new
        sp.doanh_nghiep = dn
        sp.name = "dn" + i.to_s + "sp" + j.to_s
        
        sp.save
      end
   end
  end
  
  
  desc "generate printManager db"
  task :pinlo_redis  => :environment do
  	lotype = ENV['L']
    	num = ENV['N']
    require 'redis'
    require "./generatekey.rb"
  	redis = Redis.new
    #temp = "1aaaaa"
      if Package.last == nil
        temp = "1aaaaa"
      else	
	temp = Package.last.name
      end
    temp[0] = ''
    temp = lotype.to_s + temp		  
    lo_generate = Generatekey.new(temp)
    (1..num.to_i).each do
    	packag = Package.new
    	packag.name = lo_generate.generate_one(1)
    	packag.ptype_id = Ptype.where("name=?",lotype.to_s).first.name
    	packag.save

    	(1..60).each do  	
      		# Pop instance off redis and to code object
    		code = Codegen.new
    		code.name =  (redis.spop "pincode")      
    		code.save
        


      		#Insert into PrintManager
      		pack = PrintManager.new
      		#pack.package_name = package.name
      		pack.codegen_name = code.name
          pack.package = packag
          #pack.codegen = code
      		
          #pack.ptype = package.ptype.name
      		pack.save
        end

    end

    tvalue = "0"
    File.open("value.txt", "r") do |w|
         tvalue =  w.read.to_s
    end

    insert_lo = Generatekey.new(tvalue)
    puts count = 60*num.to_i
    insert_lo.generate_code(count, "pincode")

    File.open("value.txt", "w") do |w|
        w.write tvalue
    end
       
  end


  task :readwrite => :environment do
      File.open("value.txt", "w") do |w|
        w.write "trung"

      end
  end

  task :read => :environment do
      File.open("value.txt", "r") do |w|
        puts w.read.to_s

      end
  end

  desc "Create 2 lo type 1:sua, 5:ruou"
  task :create_lo_type => :environment do
    #type sua
      ptype = Ptype.new
      ptype.name = 1
      ptype.description = "sua"
      ptype.save
    #type ruou
      ptype1 = Ptype.new
      ptype1.name = 5
      ptype1.description = "ruou"
      ptype1.save
  end

  desc "TODO" 
  task :associate_lo_pin => :environment do
      
    
  end 

end
