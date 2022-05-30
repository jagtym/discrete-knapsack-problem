defmodule DKPTest do
  use ExUnit.Case
  doctest DKP

  test "greets the world" do
    assert DKP.hello() == :world
  end
end
