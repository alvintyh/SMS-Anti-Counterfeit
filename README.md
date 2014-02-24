# SMS Anti-Counterfeit System 

A Managemnent tool for a SMPP system writen in Ruby on Rails

## Ruby Gem Usage:

	Activeadmin 	: Administration Interface. Mainly modification
	Cancan			: Authentication library
	ruby-smpp		: smpp plugin to connect to SMPP Gateway
	redis 			: generate random and storing instance passcode
	carrierwave 	: uploading library.
	magic_encoding  : unicode display.
	meta_search		: search library.
	jquery_rails	: jquery interact library.


## Version

Demo 3.0. Reuploaded.

## Structure

Program consist of 4 part.

	1. Code generator for Anti-Counterfeit verification process.

	- Code generate using Redis to store 5 million code sequence. (6 digit 1-9a-z sequence)
	- Random code picking using Rake Task. Console command to input to sql database.

	2. Website interface:

	- Homepage. simple html display
	- Search page. 

	3. Management system:

	- Manage randomed codes, stamp distribution, administration control, retailers control, companies details, products details

	4. SMPP Gateway:

	- Recieve message, source addresss, destination address, convert and return message.