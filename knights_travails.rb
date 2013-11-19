require './tree_node_knights.rb'

class KnightPathFinder
  attr_reader :root, :positions_visited

  def initialize(start_position)
    @start_position = start_position
    @knight_moves = [[2, 1],[-2, -1],[1, 2],[-1, -2],[1, -2],[-1, 2],[2, -1],[-2, 1]]
    @positions_visited = [start_position]
    @root = TreeNode.new(@start_position)
    p "print me"
    build_move_tree(@root)
    p "now print me"
  end

  def build_move_tree(node)
    new_root = node
   
    new_children = new_move_positions(new_root.value) #array of positions
    new_children.each do |child_position| #child still coordinates

      next if @positions_visited.include?(child_position)
      
      if @positions_visited.length <= 64 # deciding what to exclude
        p @positions_visited.length
        @positions_visited << child_position #unless @positions_visited.include?(child_pos)
        child_node = TreeNode.new(child_position)
        new_root.child = child_node
        build_move_tree(child_node) #unless @positions_visited.length == (8 * 8)
      end
    end
  end

  def new_move_positions(current_pos) #WORKS
    return [] if current_pos.nil?
    possible_moves = vectors_to_moves(current_pos, @knight_moves) #array of positions
    possible_moves.delete_if { |move| !valid_move?(move) } #no longer returns any nil children
  end

  def vectors_to_moves(position, vectors) #WORKS
    possible_moves = []
    vectors.each do |vector|
      new_x = position[0] + vector[0]
      new_y = position[1] + vector[1]
      possible_moves << [new_x, new_y]
    end
    possible_moves
  end

  def valid_move?(move) #WORKS
    move.all? { |coord| coord >= 0 && coord < 8 }
  end

  # def find_path(end_pos)
# 
#     #return an array of positions
#   end

end

