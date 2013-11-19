class TreeNode
  attr_accessor :parent
  attr_reader :value, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def child=(child)
    unless child == self
      self.children << child
      child.parent = self
    end
  end

  def children=(new_children)
    new_children.delete_if { |child| child == self }
    new_children.each { |child| child.parent = self }
    @children += new_children
  end

  def dfs(target = nil)
    found = nil
    nodes = [self]
    until nodes.empty? || found
      popped_node = nodes.pop

      if block_given?
        return popped_node if yield(popped_node)
      end

      if popped_node.value == target
        found = popped_node
      else
        popped_node.children.reverse.each do |child|
          nodes << child
        end
      end
    end
    found
  end

  def bfs(target = nil)
    found = nil
    nodes = [self]
    until nodes.empty? || found
      shifted_node = nodes.shift

      if block_given?
        return shifted_node if yield(shifted_node)
      end

      puts "we are at node #{shifted_node.value}"
      if shifted_node.value == target
        found = shifted_node
      else
        shifted_node.children.each do |child|
          nodes << child
        end
      end
    end
    found
  end

end



root = TreeNode.new(10)
node5 = TreeNode.new(5)
node12 = TreeNode.new(12)
node3 = TreeNode.new(3)

node8 = TreeNode.new(8)
node11 = TreeNode.new(11)
node14 = TreeNode.new(14)
node2 = TreeNode.new(2)
node4 = TreeNode.new(4)
node6 = TreeNode.new(6)

node9 = TreeNode.new(9)
node1 = TreeNode.new(1)

#

root.children = [node5, node12]
node5.children = [node3, node8, node5]
node12.children = [node11, node14]
node3.children = [node2, node4]
node8.children = [node6, node9]
node2.child = node1

# p root.dfs(1)
# puts
# p root.dfs(4)
# puts
# p root.dfs(9)
# puts
# p root.dfs(14)
# puts
# var = root.dfs(13)
# p var

# p root.bfs(1)
# puts
# root.bfs(4)
# puts
# root.bfs(9)
# puts
# root.bfs(14)
# p root.bfs(13)

# p root.bfs { |node| node.value == 9 }

p root.dfs { |node| node.value == 9 }









