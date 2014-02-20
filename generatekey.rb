# -*- encoding : utf-8 -*-
class Generatekey

	require 'redis'

	attr_accessor :shorturl, :last, :redis
	def hello
		puts "Hello"
	end

	def initialize (shortur="maaaaa")
		@redis = Redis.new
		@last = "lastone"
		@shorturl = shortur
		#puts "new all initialize"
	end

		#def gendigit
	def increment_code
		#shorturl = "a9999"
		carry = false 
		for i in 1..(shorturl.length) do 
			 #this is your starting string 
			index =  shorturl.length - i
			if index == shorturl.length - 1
				char = shorturl[index].ord 
				char = char.next
				if char == 123
					char = 48 
				elsif char == 58 
					char = 97 
					carry = true 
				end 
				shorturl[index] = char.chr 
			elsif carry
				carry = false 
				char = shorturl[index].ord 
				char = char.next
				if char == 123 
					char = 48 
				elsif char == 58 
					char = 97 
					carry = true 
				end 
				shorturl[index] = char.chr 
			end 
		end 
		if carry 
			puts "over bound"
			shorturl = "a" + shorturl 
		end 
		return shorturl 
	end #sthash.aKmZHmrS.dpuf	
	#puts redis.smembers 'all1'
	def generate_one(last_num)
		(1..last_num).each do
			increment_code
			
		end
		return shorturl
	end	


	def generate_code(last_num,rfile)
		time_start = Time.now

			(1..last_num).each do
				increment_code
				redis.sadd rfile, shorturl
				#puts shorturl
			end	
		time_end = Time.now
		return shorturl
		#puts (times_end - time_start)
		puts "Time elapsed #{(time_start - time_end)} seconds"
		#temp = redis.srandmember 'all1', 6
	end	
end
