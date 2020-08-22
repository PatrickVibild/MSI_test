defmodule BST do
  @moduledoc false

  def new([]), do: []
  def new([head | tail]) do
    insert(nil, head)
    |> insert_recursive(tail)
  end

  def add(pre_order_tree, element) when is_list(pre_order_tree) do
    Enum.concat(pre_order_tree, [element])
      |> new
  end

  def pre_order(tree = %Leaf{}) do
    [[tree.value | pre_order(tree.left_leaf)] | pre_order(tree.right_leaf)]
    |> List.flatten
  end
  def pre_order(_tree), do: []

  defp insert(tree, value) when is_nil(tree) do
    %Leaf{value: value}
  end
  defp insert(tree = %Leaf{}, value) do
    if value > tree.value do
      %Leaf{tree | right_leaf: insert(tree.right_leaf, value)}
    else
      %Leaf{tree | left_leaf: insert(tree.left_leaf, value)}
    end
  end

  defp insert_recursive(root, []), do: root
  defp insert_recursive(root, [head | tail]) do
    insert(root, head)
    |> insert_recursive(tail)
  end

end
