# require "byebug"
class Word_chainer
    DICTIONARY = 'dictionary.txt'
    WORDS = File.readlines(DICTIONARY).map { |word| word.chomp }

    def initialize(starting_word, ending_word)
        @starting_word = starting_word
        @ending_word = ending_word
        @chain_word = starting_word
        @length = starting_word.length
        @chain_words = []
    end

    def generate_random_alphabit
        alphabits = ("a".."z").to_a
        alphabits.sample
    end

    def exists_in_dictionary?(word)
        WORDS.include?(word)
    end

    def exists_in_chain_words?(word)
        @chain_words.include?(word)
    end


    def chain_words
        (0...@length).each do |idx|

            next if @chain_word[idx] == @ending_word[idx] 

            cpy_chain_word = @chain_word.dup
            @chain_word[idx] = @ending_word[idx]

            until exists_in_dictionary?(@chain_word) do
                @chain_word[idx] = generate_random_alphabit
            end

            if exists_in_chain_words?(@chain_word) 
                @chain_word = cpy_chain_word
            else
                @chain_words << @chain_word.dup
            end
        end 
        @chain_words

    end

    def get_chain
        chain_words until @chain_word == @ending_word 
        @chain_words
    end

end
