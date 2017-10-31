require "./piles.rb"

class Board
	def initialize()
		@deck = Deck.new()
		# @draw = Draw.new()
		@field = [Pile.new(@deck.cards.pop(1)), Pile.new(@deck.cards.pop(2)), Pile.new(@deck.cards.pop(3)),Pile.new(@deck.cards.pop(4)), Pile.new(@deck.cards.pop(5)),Pile.new(@deck.cards.pop(6))]
		@finished = [Finished_Pile.new("h"),Finished_Pile.new("d"),Finished_Pile.new("s"),Finished_Pile.new("c")]
		self.display_board
	end
	def display_board
		puts self.inspect
		# puts @deck.inspect
		# puts @draw.inspect
		puts "The sorted piles are: Hearts: #{@finished[0].show}, Diamonds: #{@finished[1].show}, Spades: #{@finished[2].show}, Clubs: #{@finished[3].show}"
		puts "The piles in play are:"
		puts "Press '1' to play: #{@field[0].show}"
		puts "Press '2' to play: #{@field[1].show}"
		puts "Press '3' to play: #{@field[2].show}"
		puts "Press '4' to play: #{@field[3].show}"
		puts "Press '5' to play: #{@field[4].show}"
		puts "Press '6' to play: #{@field[5].show}"
		@deck.show_draw
		puts "what move will you make?"
		self.prompt
	end
	def prompt
		@currentmove = gets.chomp
		# puts @currentmove
		if @currentmove[0] == "q"
			puts "See you next time"
		elsif @currentmove[0] == "f"
			self.flip
			puts "Flipped the top 3 cards"
			self.display_board
		elsif @currentmove.to_i.between?(0,6) || @currentmove == "d"
			puts "nice one!"
			self.find_move(@currentmove)	
			self.display_board
		else
			puts "invalid move, try again:"
			self.prompt
		end
	end
	def find_move(choice)
		if choice.to_i.between?(1, 6)
			@pile=@field[choice.to_i-1]
			@switch=0
		elsif choice == "d"
			if @deck.showing_cards == []
				return "Nothing to play"
			else
				@pile=@deck.showing_cards[0]
			end
			@switch=-1
		end
		@finished.each do |testpile| 
			@testcard=@pile.showing_cards[0]
			@testpile=testpile
			puts "DING"
			if @testpile.test_finish(@testcard)
				self.move_card(@pile, @testpile, 0)
				puts "move!"
				return 
			end
		end
		# @field.each do |testpile| 
		# 	@testcard=@pile.showing_cards[@switch]
		# 	puts @testcard.inspect
		# 	@testpile=testpile
		# 	if @testpile.test_play(@testcard)
		# 		return self.move_card(@pile, @testpile, 0..switch)
		# 	end
		# end
	end

	def move_card(origin, placement, position)
		@origin=origin
		@placement=placement
		@placement.showing_cards.unshift(@origin.showing_cards.shift(position))
	end
	def flip
		if @deck.show=="Empty"
			puts "flip deck"
			@deck.deck_flip
		else
			@deck.draw_flip
		end
	end
end