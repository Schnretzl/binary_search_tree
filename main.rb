require_relative 'lib/tree'

# my_array = []
# while my_array.length < 20
#   random_number = rand(100)
#   my_array << random_number unless my_array.include?(random_number)
# end
# my_tree = Tree.new(my_array)
# my_tree.pretty_print

# array_2 = [1, 2, 3]
# tree_2 = Tree.new(array_2)
# tree_2.insert(8)
# tree_2.pretty_print

array_3 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
tree_3 = Tree.new(array_3)
# tree_3.pretty_print
# tree_3.delete(1)
# tree_3.pretty_print
# tree_3.delete(9)
# tree_3.pretty_print
# tree_3.delete(5)
tree_3.pretty_print


# tree_3.level_order { |node| puts node.data }
# tree_3.inorder { |node| puts node.data }
# tree_3.preorder { |node| puts node.data }
# tree_3.postorder { |node| node.data }
p tree_3.height(tree_3.root.right)