require_relative 'tic_tac_toe_node'
require 'byebug'
class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    #create a starting tick tack toe node to represent game state at current turn
    node = TicTacToeNode.new(game.board, mark)

    win_move = self.find_winning_moves(node, mark)
    #chooses a winning move if available
    if win_move != []
      #make winning move
      return win_move[0]
    else
      # debugger
      moves = find_losing_moves(node, mark)
      if moves.length <= 0
        raise "I give up"
      else
        return moves[0]
      end
    end
  end

  def find_winning_moves(node, mark)
    moves = []
    node.children.each do |child|
      # debugger
      moves << child.prev_move_pos if child.winning_node?(mark)
    end
    return moves
  end

  def find_losing_moves(node, mark)
    moves = []
    node.children.each do |child|
      moves << child.prev_move_pos if !child.losing_node?(mark)
    end
    return moves
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
