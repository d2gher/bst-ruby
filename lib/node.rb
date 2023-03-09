# frozen_string_literal: true

# Class for node in BST
class Node
  attr_accessor :data, :right, :left

  def initialize(data)
    @data = data
    @right = nil
    @left = nil
  end
end
