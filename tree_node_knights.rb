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
    #invalid to add something that is in the used_positions array
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
        p shifted_node.value if !yield(shifted_node)
        return shifted_node if yield(shifted_node)
      end

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