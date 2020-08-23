#Note sure if this can be called a integration test when you are testing a module
#and not the application when its live.
defmodule Test.IntegrationTest.RouterTest do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test
  alias BstServer.Controller.Router

  @opts Router.init([])

  test "returns bst tree" do
    conn =
      :post
      |> conn("/insert", %{"n" => 5, "tree" => [5, 7, 6, 3, 4]})
      |> put_req_header("content-type", "application/json")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "[5,3,4,7,6]"
  end

  test "Returns a status code 400 missing 'n' on payload" do
    conn =
      :post
      |> conn("/insert", %{"motorola" => "hire_me", "tree" => [5, 7, 6, 3, 4]})
      |> put_req_header("content-type", "application/json")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 400
    assert conn.resp_body == "{\"response\":\"Missing n in json\"}"
  end

  test "Returns a bst when passing null as tree and giving a element" do
    conn =
      :post
      |> conn("/insert", %{"n" => -20, "tree" => nil})
      |> put_req_header("content-type", "application/json")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "[-20]"
  end
end
