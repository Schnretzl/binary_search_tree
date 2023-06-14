require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr, first_index = 0, last_index = arr.length - 1)
    arr.nil? || arr.uniq!
    arr.nil? || arr.sort!
    @root = build_tree(arr, first_index, last_index)
  end

  def build_tree(arr, first_index, last_index)
    return nil if first_index > last_index || arr.nil?

    mid = (first_index + last_index) / 2
    @root = Node.new(arr[mid])
    @root.left = Tree.new(arr, first_index, mid - 1)
    @root.right = Tree.new(arr, mid + 1, last_index)
    @root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?

    pretty_print(node.right.root, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left.root, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
