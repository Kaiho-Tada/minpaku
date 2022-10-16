class SearchesController < ApplicationController

    def search
        word = params[:word]
        if word.is_roman?
            @word_roman = word
            @word_kana = Romaji.romaji2kana(word)
            @word_hira = Romaji.romaji2kana(word).to_hira
            
        elsif word.is_hira? 
            @word_hira = word
            @word_kana = word.to_kana
            @word_roman = word.to_roman
            
        elsif word.is_kana?
            @word_kana = word
            @word_hira = word.to_hira
            @word_roman = word.to_roman
        else
            @word_exception = word
        end

        if @word_exception
            @rooms = Room.looks_exception(@word_exception)
        else
            @rooms = Room.looks(@word_kana, @word_hira, @word_roman)
        end   
    end

    def search_place
        @rooms = Room.looks_place(params[:word])
    end
end
