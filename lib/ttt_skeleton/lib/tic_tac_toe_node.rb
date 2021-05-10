require_relative 'tic_tac_toe'
require 'byebug'
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = []
  end

  def losing_node?(evaluator)
    # debugger
    other_mark = (evaluator == :o ? :x : :o)
    winner = self.board.winner
    if self.board.over?
      if winner == other_mark && self.board.won?
        return true
      else 
        return false
      end
    end

    if evaluator == self.next_mover_mark
      return self.children.all? { |child| child.losing_node?(evaluator) }
    else
      return self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    #check if current player has won
    other_mark = (evaluator == :o ? :x : :o)
    winner = self.board.winner
    if self.board.over?
      if winner == evaluator
        return true
      else
        return false
      end
    end
    #when it is the player's turn, if they haven't won, check all children to see if they can setup to win
    if evaluator == self.next_mover_mark
      return self.children.any? { |child| child.winning_node?(evaluator) }
    else  #check every child of self to see if all are winners 
      return self.children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if @board.empty?([i, j])
          pos = [i, j]
          mark = (next_mover_mark == :o ? :x : :o)
          new_board = board.dup
          new_board[pos] = next_mover_mark
          temp = TicTacToeNode.new(new_board, mark, @prev_move_pos)
          temp.prev_move_pos.concat(pos)
          children << temp
        end
      end
    end
    children
  end

end