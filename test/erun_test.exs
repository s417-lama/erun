defmodule ErunTest do
  use ExUnit.Case
  doctest Erun

  test "greets the world" do
    assert Erun.hello() == :world
  end
end
