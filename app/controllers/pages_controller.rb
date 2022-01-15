require 'json'
require 'open-uri'

class PagesController < ApplicationController

  def home
    @letter_array = 8.times.map {('A'..'Z').to_a.sample}
  end

  def results
    @answer = params["answer"].upcase
    if according_to_grid?(@answer) && english?(@answer)
      @results = "It is according to grid and an English word"
    elsif according_to_grid?(@answer) && !english?(@answer)
      @results = "It is according to grid but not an English word"
    else
      @results = "not the vibe"
    end
  end

  def according_to_grid?(word)
    booleans = []
    grid = params["letters"]
    word_array = word.chars
    word_array.each do |letter|
      if grid.include?(letter)
        #try !@letter_array.include?(letter) return false, outside the loop return true
        grid.delete!(letter)
        booleans << true
      else
        booleans << false
      end
    end
    !booleans.include?(false)
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word_info = JSON.parse(word_serialized)
    word_info["found"]
  end

end
