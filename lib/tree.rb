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
    while tmp.left || tmp.right
      tmp = value < tmp.data ? tmp.left : tmp.right
    end

    value < tmp.data ? tmp.left = Node.new(value) : tmp.right = Node.new(value)
  end

  def delete(value)
    return if value.nil?

    parent = find_parent(value)
    delete_node = find(value)
    if parent == delete_node
      delete_parent
    elsif delete_node.left.nil? && delete_node.right.nil?
      delete_node.data < parent.data ? parent.left = nil : parent.right = nil
    elsif (delete_node.left.nil? && !delete_node.right.nil?) || (!delete_node.left.nil? && delete_node.right.nil?)
      if delete_node.data > parent.data
        parent.right = delete_node.left.nil? ? delete_node.right : delete_node.left
      else
        parent.left = delete_node.left.nil? ? delete_node.right : delete_node.left
      end
    else
      temp = find_max(delete_node.left)
      temp_parent = find_parent(temp.data)
      temp.data > parent.data ? parent.right = temp : parent.left = temp
      temp.left = delete_node.left
      temp.right = delete_node.right
      temp_parent.right = nil
    end
  end

  def delete_parent
    temp = find_max(@root.left)
    temp_parent = find_parent(temp.data)
    temp.left = @root.left
    temp.right = @root.right
    @root = temp
    temp_parent.right = nil
  end

  def find(value)
    node = @root
    while node && node.data != value
      node = value < node.data ? node.left : node.right
      puts 'Value not found!' if node.nil?
    end
    node
  end

  def find_parent(value)
    node = @root
    return node if node.data == value
    parent = nil

    until node.nil?
      if (node.left && node.left.data == value) || (node.right && node.right.data == value)
        parent = node
        break
      end

      node = value < node.data ? node.left : node.right
    end

    puts 'Value not found!' if parent.nil?
    parent
  end

  def find_max(node)
    node = node.right until node.right.nil?
    node
  end

  def level_order
    node_arr = [@root]
    return_arr = []
    while node_arr.any?
      node_arr << node_arr[0].left unless node_arr[0].left.nil?
      node_arr << node_arr[0].right unless node_arr[0].right.nil?
      yield node_arr.shift if block_given?
      return_arr << node_arr.shift.data unless block_given?
    end
    return return_arr unless block_given?
  end

  def inorder(node = @root, &block)
    return [] if node.nil?

    return_arr = []
    return_arr += inorder(node.left, &block) if node.left
    return_arr << node if block_given?
    return_arr << node.data unless block_given?
    return_arr += inorder(node.right, &block) if node.right

    if node == @root
      return_arr.each { |item| yield item } if block_given?
      return return_arr unless block_given?
    else
      return_arr
    end
  end

  def preorder(node = @root, &block)
    return [] if node.nil?

    return_arr = []
    return_arr << node if block_given?
    return_arr << node.data unless block_given?
    return_arr += preorder(node.left, &block) if node.left
    return_arr += preorder(node.right, &block) if node.right

    if node == @root
      return_arr.each { |item| yield item } if block_given?
      return return_arr unless block_given?
    else
      return_arr
    end
  end

  def postorder(node = @root, &block)
    return [] if node.nil?

    return_arr = []
    return_arr += postorder(node.left, &block) if node.left
    return_arr += postorder(node.right, &block) if node.right
    return_arr << node if block_given?
    return_arr << node.data unless block_given?

    if node == @root
      return_arr.each { |item| yield item } if block_given?
      return return_arr unless block_given?
    else
      return_arr
    end
  end

  def height(node)
    return 0 if (node.left.nil? && node.right.nil?) || node.nil?
    return height(node.right) + 1 if node.left.nil?
    return height(node.left) + 1 if node.right.nil?

    height_left = height(node.left) if node.left
    height_right = height(node.right) if node.right

    height_left > height_right ? height_left + 1 : height_right + 1
  end

  def depth(node)
    return 0 if node == @root || node.nil?

    traverse_node = @root
    depth = 0
    while traverse_node && traverse_node.data != node.data
      traverse_node = node.data < traverse_node.data ? traverse_node.left : traverse_node.right
      depth += 1
    end
    depth
  end

  def balanced?(node = @root)
    return true if node.nil? || (node.left.nil? && node.right.nil?)
    return false if node.left.nil? && height(node.right) != 0
    return false if node.right.nil? && height(node.left) != 0

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    return self if balanced?

    balanced_tree_arr = inorder
    Tree.new(balanced_tree_arr)
  end

end
