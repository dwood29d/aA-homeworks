require 'byebug'

class PolyTreeNode
  attr_accessor :children, :parent, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    node.children << self unless node.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if child_node.parent.nil?
      raise 'This child has no parent'
    end
    child_node.parent = nil
  end

  def inspect
    { 'value' => @value, 'parent_value' => @parent.value }.inspect
  end

  def dfs(target_value)
    return self if target_value == self.value
    # debugger
    children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each { |child| queue.push(child) }
    end
  end

end
