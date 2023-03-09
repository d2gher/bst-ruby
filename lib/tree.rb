# frozen_string_literal: true

require_relative 'node'

# Class for binary search tree
class Tree
  attr_accessor :root, :data

  def initialize(arr)
    @data = arr.sort.uniq
    @root = build_tree(@data)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = (arr.length - 1) / 2
    root = Node.new(arr[mid])

    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[mid + 1..])

    root
  end

  def insert(data, node = root)
    return Node.new(data) if node.nil?
    return node if node.data == data

    if data > node.data
      node.right = insert(data, node.right)
    else
      node.left = insert(data, node.left)
    end

    node
  end

  def min_value_node(node)
    return node if node.left.nil?

    min_value_node(node.left)
  end

  def delete(data, node = root)
    return node if node.nil?

    if node.data > data
      node.left = delete(data, node.left)
    elsif node.data < data
      node.right = delete(data, node.right)
    else
      return nil if node.left.nil? && node.right.nil?
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      temp = min_value_node(node.right)
      node.data = temp.data

      node.right = delete(temp.data, node.right)
    end
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 400]
arr2 = [1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345]
trr = Tree.new(arr)
trr.insert(2)
trr.pretty_print

trr.delete(8)
trr.pretty_print
