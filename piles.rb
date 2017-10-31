require "./cards.rb"

class Pile
	attr_reader :cards, :showing_cards
	attr_writer :cards, :showing_cards
	def initialize(cards)
		@cards = []
		@showing_cards =[]
		if cards		
			@cards.push(cards).flatten!
		end
		self.show
	end

	def show
		if @showing_cards.count==0 
			if @cards.count == 0
				return "Empty"
			else
				@showing_cards.unshift(@cards.shift(1)).flatten!
				self.show
			end
		elsif @showing_cards.count==1
			return @showing_cards[0].display_card
		else
			return "from "+@showing_cards[0].display_card+" to "+@showing_cards[-1].display_card
		end
	end
	def test_play(testcard)
		@testcard=testcard
		if @cards[0].red_card? != @testcard.red_card? 
			if (@testcard.number-1) == self.cards[0].number
				puts "CORRECT"
				true
			end
			if self.show == "Empty" 
				if @testcard.number ==13
					puts "CORRECT"
					true
				end
			end
		end
		false
	end
end

class Finished_Pile < Pile
	attr_reader :suit, :cards, :showing_cards
	attr_writer :suit, :cards, :showing_cards
	def initialize(suit)
		@suit=suit
		@cards=[]
		@showing_cards = []
	end
	def test_finish(testcard)
		@testcard=testcard
		if @suit == @testcard.suit 
			if @showing_cards.count == 0
				if @testcard.number == 1
					puts "ACE"
					return true
				end
			else		
				if @testcard.number -1 == @showing_cards[0].number
					puts "CORRECT"
					return true
				end
			end
		end
		return false
	end
end

class Deck < Pile
	def initialize()
		@cards = []
		@showing_cards = []
		["h", "d", "s", "c"].each do |suit|
			for i in 1..13 
				@cards.push(Card.new(suit, i))
			end
		end
		@cards = @cards.shuffle
	end	
	def deck_flip()
		while @showing_cards.count > 0
			@cards.unshift(@showing_cards.pop)
		end
		@cards.flatten!
	end
	def draw_flip
		@showing_cards.unshift(@cards.shift(3).reverse).flatten!
		# @cards.flatten!
	end
	def show_draw
		print "The current draw pile is:"
		if @showing_cards.count==0
			puts "Empty"
		else
			if @showing_cards[0]
				print @showing_cards[0].display_card + ", "
				if @showing_cards[1]
					print @showing_cards[1].display_card + ", "
					if @showing_cards[2]
						puts @showing_cards[2].display_card
					end
				end
			end			
			puts "You may play the #{@showing_cards[0].display_card} with (D)"
		end
		puts "Flip 3 more cards with (F)"
	end
end

