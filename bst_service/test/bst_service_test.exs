defmodule BstServiceTest do
  use ExUnit.Case
  doctest BstService

  test "greets the world" do
    assert BstService.hello() == :world
  end
end
