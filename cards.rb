require "./rules.rb"

class Card
	attr_reader :suit, :number
	attr_writer :suit, :number
	def initialize(suit, number)
		@suit=suit
		@number=number
	end
	def suit_translate
		if @suit == "h"
			"Hearts" 
		elsif @suit == "d"
			"Diamonds" 
		elsif @suit == "c"
			"Clubs" 
		elsif @suit == "s"
			"Spades" 
		else
			"ERROR"
		end
	end	
	def number_translate
		if @number == 1
			"Ace"
		elsif @number.between?(2, 10)
			@number
		elsif @number.between?(11, 13)
			["Jack", "Queen", "King"][@number-11]
		else
			"ERROR"
		end		
	end
	def red_card?
		true if @suit == "h" || @suit ==  "d"
		false if @suit == "c" || @suit == "s"
	end
	def display_card
		"#{self.number_translate} of #{self.suit_translate}"
	end
end
