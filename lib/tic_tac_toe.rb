class TicTacToe
    attr_reader :board

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        print " #{board[0]} | #{board[1]} | #{board[2]} "
        print "-----------"
        print " #{board[3]} | #{board[4]} | #{board[5]} "
        print "-----------"
        print " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index input
        integer = input.to_i - 1
    end

    def move index_in_board, token = "X"
        board[index_in_board] = token
    end

    def position_taken? index_value
        if board[index_value] == " "
            false
        else
            true
        end
    end

    def valid_move? index
       if position_taken? index
        false
       elsif index >= 0 && index <= 8
        true
       end
    end

    def turn_count
        board.filter{|space| space != " "}.length
    end

    def current_player
        if turn_count % 2 == 0
            "X"
        else
            "O"
        end
    end

    def turn
        puts "Please enter a number (1-9)"
        input = gets.strip
        index = input_to_index input
        if valid_move? index
            move(index, current_player)
        else
            turn
        end
        display_board
    end

    def won?
        # Find index of X winner
        x_winners = WIN_COMBINATIONS.map do |combo|
            combo.all? {|index| board[index].include?("X")}
        end

        x_win = x_winners.map.with_index {|value, index| value ? index : value}.detect{|value| value != false}

        # Find index of O winner
        o_winners = WIN_COMBINATIONS.map do |combo|
            combo.all? {|index| board[index].include?("O")}
        end

        o_win = o_winners.map.with_index {|value, index| value ? index : value}.detect{|value| value != false}

        if x_winners.include?(true)
            WIN_COMBINATIONS[x_win]
        elsif o_winners.include?(true)
            WIN_COMBINATIONS[o_win]
        else
            false
        end
    end

    def full?
        board.include?(" ") ? false : true
    end

    def draw?
        full? && !won? 
    end

    def over?
        draw? || won?
    end

    def winner
        if won?
            turn_count % 2 == 0 ? "O" : "X"
        end
    end

    def play
        turn until over?

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

end



