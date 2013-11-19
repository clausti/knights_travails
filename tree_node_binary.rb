class TreeNode
  attr_accessor :parent
  attr_reader :value, :left, :right

  def initialize(value)
    @value = value
    @parent = nil
    @left = nil
    @right = nil
  end

  def left=(child)
    @left.parent = nil unless @left.nil?
    unless child == self
      @left = child
      child.parent = self
    end
  end

  def right=(child)
    @right.parent = nil unless @right.nil?
    unless child == self
      @right = child
      child.parent = self
    end
  end

  def dfs(target)
    found = nil
    if self.value == target
      found = self
    else
      unless self.left.nil? || found
        found = self.left.dfs(target)
      end
      unless self.right.nil? || found
        found = self.right.dfs(target)
      end
    end
    found
  end

  def bfs(target)
    found = nil
    nodes = [self]
    until nodes.empty? || found
      shifted_node = nodes.shift
      if shifted_node.value == target
        found = shifted_node
      else
        nodes << shifted_node.left unless shifted_node.left.nil?
        nodes << shifted_node.right unless shifted_node.right.nil?
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
root.left = node5
root.left.left = node3
root.left.left.left = node2
root.left.left.left.left = node1

root.left.left.right = node4
root.left.right = node8
root.left.right.left = node6
root.left.right.right = node9

root.right = node12
root.right.left = node11
root.right.right = node14

# root.dfs(1)
# puts
# root.dfs(4)
# puts
# root.dfs(9)
# puts
# root.dfs(14)
# puts
# var = root.dfs(13)
# p var
#
p root.bfs(1)
puts
root.bfs(4)
puts
root.bfs(9)
puts
root.bfs(14)
p root.bfs(13)









