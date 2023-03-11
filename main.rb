# frozen_string_literal: true

require_relative './lib/tree'

# Create random array
array = (Array.new(15) { rand(1..100) })

# Create new BST
tree = Tree.new(array)

# Confirm if balanced
puts "Tree is balanced? #{tree.balanced?}"
puts ''

# Pre, post, and inorder traversal
puts 'Preorder:'
p tree.preorder
puts ''
puts 'Postorder:'
p tree.postorder
puts ''
puts 'Inorder:'
p tree.inorder
puts ''

# Unbalance
puts 'Try to unbalance the tree by adding several numbers > 100'
tree.insert(107)
tree.insert(115)
tree.insert(101)
tree.insert(109)
puts "Tree is balanced? #{tree.balanced?}"
puts ''

# Rebalance tree
tree = tree.rebalance
puts 'Try to rebalance tree'
puts "Tree is balanced? #{tree.balanced?}"
puts ''

# Pre, post, and inorder traversal
puts 'Preorder:'
p tree.preorder
puts ''
puts 'Postorder:'
p tree.postorder
puts ''
puts 'Inorder:'
p tree.inorder
puts ''
