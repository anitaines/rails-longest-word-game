require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = []
    leters = ('A'..'Z').to_a
  
    @grid << leters.sample until @grid.size == 10

    @ana = "ana"
  end

  def score
    # raise
    # binding.pry
    @grid = params[:grid]
    @word = params[:word]
    
    @result = if !in_grid?(@word, @grid)
                # "Sorry but #{<b>@word.upcase</b> } can't be built out of #{@grid.chars.join(', ')}"
                "not in grid"
              elsif !valid?(@word)
                # "Sorry but #{@word.upcase } does not seem to be a valid English word..."
                "not valid"
              else
                # "Congratulations! #{@word.upcase } is a valid English word!"
                "success"
              end
    
  end

  def in_grid?(word, grid)
    word.upcase.chars.all? do |letter|
      grid.include?(letter)
      grid.slice!(grid.index(letter)) if grid.include?(letter)
    end
  end

  def valid?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    le_dictionary_serialized = URI.open(url).read
    word = JSON.parse(le_dictionary_serialized)
    word["found"]
  end
end
