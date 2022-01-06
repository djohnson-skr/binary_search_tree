require 'pp'

class Node

  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree

  attr_accessor :data, :root

  def initialize(array)
    @data = array
    @root = build_tree(@data) # builds out the tree (collection of nodes)
  end

  def build_tree(array)
    return nil if array.empty?
  
    array.sort!.uniq!
    mid = (array.length-1)/2

    root_node = Node.new(array[mid])
    root_node.left = build_tree(array[0...mid])
    root_node.right = build_tree(array[mid+1..-1])

    root_node
  end

  def insert(val, node = @root)
    # looks at the first node, specifically its data attribute (recursion looks at next -> node.left...)
    puts "dupliate" if val == node.data # handles if there is a duplicate
    return nil if val == node.data 

    if val < node.data
      node.left.nil? ? node.left = Node.new(val) : insert(val,node.left)
    else
      node.right.nil? ? node.right = Node.new(val) : insert(val, node.right)
    end
  end

  def delete(val, node = @root)
    return node if node.nil?

    if val < node.data
      node.left = delete(val, node.left)
    elsif val > node.data
      node.right = delete(val, node.right)
    end

    if val == node.data
      # if node has one or no child
      if node.left.nil?
        node = node.right
      else node.right.nil?
        node = node.left
      end
    end
    #node
    
  
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end



tree = Tree.new([1,2,3,4,5,6,7])
#tree.insert(10)
tree.pretty_print
puts 
tree.delete(1)
tree.pretty_print
