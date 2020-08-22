defmodule BstServiceTest do
  use ExUnit.Case
  doctest BstService

  test "creates a BST of integers" do
    assert BstService.new([0, -1, 1]) ==
             %Leaf{
               left_leaf: %Leaf{
                 left_leaf: nil,
                 right_leaf: nil,
                 value: -1
               },
               right_leaf: %Leaf{
                 left_leaf: nil,
                 right_leaf: nil,
                 value: 1
               },
               value: 0
             }
  end

  test "BST skip add duplicated elements only once" do
    assert BstService.new([100, 100, 100]) ==
             %Leaf{left_leaf: nil, right_leaf: nil, value: 100}
  end

  test "Add element to a BST" do
    assert BstService.add([0, -1], 1) ==
             %Leaf{
               left_leaf: %Leaf{
                 left_leaf: nil,
                 right_leaf: nil,
                 value: -1
               },
               right_leaf: %Leaf{
                 left_leaf: nil,
                 right_leaf: nil,
                 value: 1
               },
               value: 0
             }
  end

  test "Create a BST of with different data type" do
    assert BstService.new(
             [10, &(&1 + &2), 10, %{name: "patrick", last: "vibild"}, "helloworld", [0], [keyword: "list"]]
           ) ==
             %Leaf{
               left_leaf: nil,
               right_leaf: %Leaf{
                 left_leaf: nil,
                 right_leaf: %Leaf{
                   left_leaf: nil,
                   right_leaf: %Leaf{
                     left_leaf: %Leaf{
                       left_leaf: nil,
                       right_leaf: %Leaf{
                         left_leaf: nil,
                         right_leaf: nil,
                         value: [
                           keyword: "list"
                         ]
                       },
                       value: [0]
                     },
                     right_leaf: nil,
                     value: "helloworld"
                   },
                   value: %{
                     last: "vibild",
                     name: "patrick"
                   }
                 },
                 value: &:erlang.+/2
               },
               value: 10
             }
  end

  test"Pass a tree map and print its pre_order" do
    tree = %Leaf{
      left_leaf: nil,
      right_leaf: %Leaf{
        left_leaf: nil,
        right_leaf: %Leaf{
          left_leaf: nil,
          right_leaf: %Leaf{
            left_leaf: %Leaf{
              left_leaf: nil,
              right_leaf: %Leaf{
                left_leaf: nil,
                right_leaf: nil,
                value: [
                  keyword: "list"
                ]
              },
              value: [0]
            },
            right_leaf: nil,
            value: "helloworld"
          },
          value: %{
            last: "vibild",
            name: "patrick"
          }
        },
        value: &:erlang.+/2
      },
      value: 10
    }
    assert BstService.pre_order(tree) == [
             10,
             &:erlang.+/2,
             %{last: "vibild", name: "patrick"},
             "helloworld",
             0,
             {:keyword, "list"}
           ]
  end

  test"Pre_order of a empty tree" do
    tree = nil
    assert BstService.pre_order(tree) == []
  end
end
