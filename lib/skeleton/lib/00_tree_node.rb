require 'byebug'
class PolyTreeNode

    attr_reader :value, :children, :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        if @parent != nil
            @parent.children.reject! { |child| child == self}
        end

        @parent = parent_node
        if parent_node != nil
            parent_node.children << self if !parent_node.children.include?(self)
        end
    end

    def add_child(child_node)
        if !@children.include?(child_node)
            @children << child_node
            child_node.parent = self
        end
    end

    def remove_child(child_node)
        if child_node && !self.children.include?(child_node)
            raise "no child found"
        end
        child_node.parent = nil
    end

    def dfs(target)
        if self.value == target
            return self
        end

        self.children.each do |child|
            a = child.dfs(target)
            return a if a != nil
        end
        nil
    end

    def bfs(target)

        queue = []  #intialize empty queue
        queue.unshift(self) #add first node to beginnning of queue
        searched = Hash.new(false)  #prevent double searches
        # searched[self] = true   #verify search of initial node

        until queue.empty?
            node = queue.shift  #dequeue first element
            next if searched[node] == true

            if node.value == target
                return node
            end

            searched[node] = true   #mark as searched

            node.children.each do |child|
                queue << child  #add all children to queue
            end
        end
        nil
    end
end