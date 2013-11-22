require './tree_node_knights.rb'

class KnightPathFinder
  attr_reader :root, :positions_visited

  def initialize(start_position)
    @start_position = start_position
    @knight_moves = [[2, 1],[-2, -1],[1, 2],[-1, -2],[1, -2],[-1, 2],[2, -1],[-2, 1]]
    @root = TreeNode.new(@start_position)
    build_move_tree(@root)
  end

  def build_move_tree(node)
    new_root = node
    return if self.find_depth(node) > 6
    new_children = new_move_positions(new_root.value)
    new_children.each do |child_position|
      child_node = TreeNode.new(child_position)
      new_root.child = child_node
      build_move_tree(child_node)
    end
  end

  def new_move_positions(current_pos)
    return [] if current_pos.nil?
    possible_moves = vectors_to_moves(current_pos, @knight_moves) 
    possible_moves.delete_if { |move| !valid_move?(move) }
  end

  def vectors_to_moves(position, vectors)
    possible_moves = []
    vectors.each do |vector|
      new_x = position[0] + vector[0]
      new_y = position[1] + vector[1]
      possible_moves << [new_x, new_y]
    end
    possible_moves
  end

  def valid_move?(move)
    move.all? { |coord| coord >= 0 && coord < 8 }
  end

  def find_path(end_pos)
    target = self.root.bfs(end_pos)
    self.trace_to_root(target)
  end
  
  def find_depth(node)
    path = self.trace_to_root(node)
    return path.length
  end
  
  def trace_to_root(node)
    path = [node.value]
    until node.parent.nil?
      path.unshift(node.parent.value)
      node = node.parent
    end
    path
  end

end

