defmodule BstServer.Modules.Bst do
  alias BstServer.Modules.Leaf, as: Leaf
  @moduledoc """
  Documentation for `Bst`.

  Module that represent the data structure binary search tree (bst).

  bst can be created with function `new` having a input of a list of pre_order representation of bst.

  The module also contains a pre_order function that takes a bst as input and transform it to a list of the elements printed
  in pre order format.
  """

  @doc """
  New Binary Search Tree (BST) created from a BST pre-order list.

  Returns a map of `Leaf` representing a BST.

  ## Examples

      iex> Bst.new([5, 7, 6])
      %Leaf{left_leaf: nil, right_leaf: %Leaf{left_leaf: %Leaf{left_leaf: nil, right_leaf: nil, value: 6}, right_leaf: nil, value: 7}, value: 5}

      iex> Bst.new([])
      nil
  """

  def new([]), do: nil
  def new([head | tail]) do
    insert(nil, head)
    |> insert_recursive(tail)
  end

  @doc """
  Add a `element` to a  Binary Search Tree (BST) created from a BST `pre_order_tree` list.

  Returns a map of `Leaf` representing a BST.

  ## Examples

      iex> Bst.add([-1, 5, 2], 0)
      %Leaf{left_leaf: nil, right_leaf: %Leaf{left_leaf: %Leaf{left_leaf: %Leaf{left_leaf: nil, right_leaf: nil, value: 0}, right_leaf: nil, value: 2}, right_leaf: nil, value: 5}, value: -1}

      iex> Bst.add(nil, 3)
      %BstServer.Modules.Leaf{left_leaf: nil, right_leaf: nil, value: 3}
  """

  def add(pre_order_tree, element) when is_list(pre_order_tree) do
    Enum.concat(pre_order_tree, [element])
    |> new
  end
  def add(_pre_order_tree, element) when is_nil(_pre_order_tree) do
    new([element])
  end

  @doc """
  Returns a list representing the input `tree` in a pre-order format

  ## Examples

      iex> Bst.pre_order(%Leaf{left_leaf: %Leaf{left_leaf: nil, right_leaf: %Leaf{left_leaf: nil, right_leaf: %Leaf{left_leaf: nil, right_leaf: nil, value: -7}, value: 0}, value: -5}, right_leaf: nil, value: 10})
      [10, -5, 0, -7]
  """
  def pre_order(tree = %Leaf{}) do
    [[tree.value | pre_order(tree.left_leaf)] | pre_order(tree.right_leaf)]
    |> List.flatten
  end
  def pre_order(_tree), do: []

  defp insert(tree, value) when is_nil(tree) do
    %Leaf{value: value}
  end
  defp insert(tree = %Leaf{}, value) do
    cond do
      value > tree.value  -> %Leaf{tree | right_leaf: insert(tree.right_leaf, value)}
      value < tree.value  -> %Leaf{tree | left_leaf: insert(tree.left_leaf, value)}
      true                -> tree
    end
  end

  defp insert_recursive(root, []), do: root
  defp insert_recursive(root, [head | tail]) do
    insert(root, head)
    |> insert_recursive(tail)
  end

end
