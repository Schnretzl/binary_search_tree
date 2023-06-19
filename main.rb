require_relative 'lib/tree'

test_arr = (Array.new(15) { rand(1..100) })
test_tree = Tree.new(test_arr)
test_tree.pretty_print
puts "\nTree is balanced:  #{test_tree.balanced?}\n"
puts 'Level order traversal:'
puts "#{test_tree.level_order { |node| puts node.data }}"
puts 'Inorder traversal:'
puts "#{test_tree.inorder { |node| puts node.data }}"
puts 'Preorder traversal:'
puts "#{test_tree.preorder { |node| puts node.data }}"
puts 'Postorder traversal:'
puts "#{test_tree.postorder { |node| puts node.data }}"
test_tree.insert(110)
test_tree.insert(500)
test_tree.insert(220)
test_tree.insert(300)
test_tree.insert(480)
test_tree.pretty_print
puts "\nTree is balanced: #{test_tree.balanced?}\n"
test_tree = test_tree.rebalance
test_tree.pretty_print
puts "\nTree is balanced: #{test_tree.balanced?}\n"
puts 'Level order traversal:'
puts "#{test_tree.level_order { |node| puts node.data }}"
puts 'Inorder traversal:'
puts "#{test_tree.inorder { |node| puts node.data }}"
puts 'Preorder traversal:'
puts "#{test_tree.preorder { |node| puts node.data }}"
puts 'Postorder traversal:'
puts "#{test_tree.postorder { |node| puts node.data }}"
