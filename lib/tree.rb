# frozen_string_literal: true

require_relative 'node'

# Class for binary search tree
class Tree
  attr_accessor :root, :data

  def initialize(arr)
    @data = arr.uniq.sort
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

  def find(data, node = root)
    return node if node.data == data || node.nil?

    return find(data, node.left) if node.data > data
    return find(data, node.right) if node.data < data
  end

  def level_order
    queue = [root]
    array_of_values = [root]

    until queue.empty?
      node = queue.slice!(0)
      yield node if block_given?
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
      array_of_values += queue
    end

    array_of_values.uniq.map(&:data) unless block_given?
  end

  def inorder(node = root, queue = [], depth = 0)
    return nil if node.nil?

    inorder(node.left, queue, 1)
    queue << node
    inorder(node.right, queue, 1)

    queue.each {|node| yield node} if depth.zero? && block_given?
    queue.map(&:data)
  end

  def preorder(node = root, queue = [], depth = 0)
    return nil if node.nil?

    queue << node
    preorder(node.left, queue, 1)
    preorder(node.right, queue, 1)

    queue.each {|node| yield node} if depth.zero? && block_given?
    queue.map(&:data) if depth.zero?
  end

  def postorder(node = root, queue = [], depth = 0)
    return nil if node.nil?

    postorder(node.left, queue, 1)
    postorder(node.right, queue, 1)
    queue << node

    queue.each {|node| yield node} if depth.zero? && block_given?
    queue.map(&:data) if depth.zero?
  end

  def height(node = root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    [left_height, right_height].max + 1
  end

  def depth(node = root, pointer = root)
    return 0 if node == pointer

    return 1 + depth(node, pointer.right) if node.data > pointer.data
    return 1 + depth(node, pointer.left) if node.data < pointer.data
  end

  def balanced?(node = root, left_height = 0, right_height = 0)
    left_height = height(node.left) if node.left
    right_height = height(node.right) if node.right

    (left_height - right_height).abs < 2
  end

  def rebalance(node = root)
    inorder = inorder(node)
    Tree.new(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
