require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :start_pos, :root_node
  attr_accessor :considered_positions

  POSSIBLE_MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def initialize(start_pos)
    @start_pos = start_pos
    @root_node = PolyTreeNode.new(start_pos)
    @considered_positions = [start_pos]

    build_move_tree
  end

  def build_move_tree
    nodes = [root_node]

    until nodes.empty?
      node = nodes.shift
      pos = node.value

      new_move_positions(pos).each do |next_pos|
        # get all possible positions from here. Build nodes, add them as
        # children, add those children to the nodes list to be shifted later
        next_node = PolyTreeNode.new(next_pos)
        node.add_child(next_node)
        nodes << next_node
      end
    end
  end

  def self.valid_moves(pos)
    valid = []
    row, col = pos
    POSSIBLE_MOVES.each do |move|
      new_pos = [row + move[0], col + move[1]]
      valid << new_pos if new_pos.all? { |num| num.between?(0, 7)}
    end

    valid
  end

  def new_move_positions(pos)
    valid = KnightPathFinder.valid_moves(pos).reject { |position| considered_positions.include?(position) }
    new_positions = []
    valid.each do |position|
      considered_positions << position
      new_positions << position
    end

    new_positions
  end

  def find_path(end_pos)
    end_node = root_node.bfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(node)
    paths = [node.value]
    until node.parent.nil?
      node = node.parent
      paths << node.value
    end

    paths.reverse
  end

end
