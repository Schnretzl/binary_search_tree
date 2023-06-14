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
    root = Node.new(arr[mid])
    root.left = build_tree(arr, first_index, mid - 1)
    root.right = build_tree(arr, mid + 1, last_index)
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    return if value == @root.data || value.nil?

    tmp = @root
    tmp = value < tmp.data ? tmp.left : tmp.right until tmp.nil?

    value < tmp.data ? tmp.left = Node.new(value) : tmp.right = Node.new(value)
  end
end
