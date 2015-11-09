class HangpersonGame

	attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose
	
	def initialize(word)
		@word = word
		@guesses = ""
		@wrong_guesses = ""
		@word_with_guesses = word.gsub(/./,'-')
		@check_win_or_lose = :play
	end



	def guess(letter)

		raise ArgumentError if letter.nil?
		raise ArgumentError if letter.empty?
		raise ArgumentError if letter.match(/[^a-zA-Z]/)

		letter.downcase!

		if @word.include?(letter) && !@guesses.include?(letter)
			@guesses << letter
			for i in 0..word.length
				if @word[i] == letter
					@word_with_guesses[i] = letter
				end
			end
			@word_with_guesses.include?("-") ? @check_win_or_lose = :play : @check_win_or_lose = :win
		elsif !@word.include?(letter) && !@wrong_guesses.include?(letter)
			@wrong_guesses << letter
			@wrong_guesses.size < 7 ? @check_win_or_lose = :play : @check_win_or_lose = :lose
		else
			return false
		end
		
		true

	end




	def self.get_random_word
		require 'uri'
		require 'net/http'
		uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
		Net::HTTP.post_form(uri ,{}).body
	end

end
