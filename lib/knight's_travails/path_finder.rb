require_relative "polytreenode.rb"
require 'byebug'
class KnightPathFinder
    def self.valid_moves(pos)
        moves = [[2, 1], [2, -1], [1, -2], [-2, -1], [1, 2], [-1, -2], [-2, 1], [-1, 2]]
        moves.map! { |ele| sum_move(pos, ele) }
        moves.select! { |move| valid_pos?(move)}
    end
    attr_reader :root_node
    attr_accessor :traversed_positions, :cur_pos
    
    def initialize(pos = [0, 0])
        @cur_pos = pos
        @root_node = PolyTreeNode.new(pos)
        @traversed_positions = Hash.new(false)
    end

    def new_move_pos(pos)
        m = KnightPathFinder.valid_moves(pos)
        return [] if m == nil
        m.reject! { |move| @traversed_positions.has_key?(move)}
        m
    end

    def build_move_tree(root, target)

        queue = []
        queue.unshift(root)

        until queue.empty?
            node = queue.shift
            # debugger
            @traversed_positions[node.value] = true

            if node.value == target
                return root
            end

            next_moves = new_move_pos(node.value)
            next_moves.each do |move|
                a = PolyTreeNode.new(move)
                node.add_child(a)
                queue << a
            end
        end
        nil
    end

    def optimal_moves(tree)
        # lets do this next before we continue this method
        # k
        # yea
        if tree.value == target
            return tree
        end
    end
end

def sum_move(pos, move)
    [pos[0] + move[0], pos[1] + move[1]]
end

def valid_pos?(pos)
    row, col = pos
    if row < 0 || row > 7
        return false
    end

    if col < 0 || col > 7
        return false
    end
    true
end

a = KnightPathFinder.new
# a.traversed_positions[[2, 1]] = true
# debugger
tree = a.build_move_tree(a.root_node, [7, 7])
p tree


# empty queue
# add the first node
# for each node connected to this node 