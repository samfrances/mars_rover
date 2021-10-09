defmodule WorldTest do
  use ExUnit.Case

  alias MarsRover.World

  test "cannot create empty world" do
    assert {:error, _message} = World.new(0, 0)
  end

  test "cannot create one-dimensional world" do
    assert {:error, _message} = World.new(0, 1)
    assert {:error, _message} = World.new(1, 0)
  end

  test "cannot create negative world" do
    assert {:error, _message} = World.new(0, -1)
    assert {:error, _message} = World.new(-1, 0)
    assert {:error, _message} = World.new(-1, -1)
    assert {:error, _message} = World.new(-5, -8)
    assert {:error, _message} = World.new(5, -8)
    assert {:error, _message} = World.new(-5, 8)
  end

  test "can create mimimal world" do
    refute match?({:error, _message}, World.new(1, 1))
  end

  test "can create larger world" do
    refute match?({:error, _message}, World.new(100, 44))
  end

end
