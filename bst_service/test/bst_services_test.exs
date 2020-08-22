defmodule BstServicesTest do
  use ExUnit.Case
  doctest BstServices

  test "greets the world" do
    assert BstServices.hello() == :world
  end
end
