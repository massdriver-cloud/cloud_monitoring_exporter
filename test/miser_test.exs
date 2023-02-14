defmodule MiserTest do
  use ExUnit.Case
  doctest Miser

  test "greets the world" do
    assert Miser.hello() == :world
  end
end
