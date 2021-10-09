defmodule WorldTest do
  use ExUnit.Case

  require MarsRover.World
  alias MarsRover.World
  alias MarsRover.Vector2D

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

  [
    {World.new(1, 1), Vector2D.new(0, 0), true},
    {World.new(1, 1), Vector2D.new(1, 0), true},
    {World.new(1, 1), Vector2D.new(0, 1), true},
    {World.new(1, 1), Vector2D.new(1, 1), true},
    {World.new(1, 1), Vector2D.new(-1, 0), false},
    {World.new(1, 1), Vector2D.new(0, -1), false},
    {World.new(1, 1), Vector2D.new(-1, -1), false},
    {World.new(1, 1), Vector2D.new(0, 2), false},
    {World.new(1, 1), Vector2D.new(2, 0), false},
    {World.new(1, 1), Vector2D.new(2, 2), false},
    {World.new(10, 10), Vector2D.new(0, 0), true},
    {World.new(10, 10), Vector2D.new(1, 0), true},
    {World.new(10, 10), Vector2D.new(0, 1), true},
    {World.new(10, 10), Vector2D.new(1, 1), true},
    {World.new(10, 10), Vector2D.new(5, 0), true},
    {World.new(10, 10), Vector2D.new(0, 5), true},
    {World.new(10, 10), Vector2D.new(5, 5), true},
    {World.new(10, 10), Vector2D.new(6, 1), true},
    {World.new(10, 10), Vector2D.new(1, 6), true},
    {World.new(10, 10), Vector2D.new(6, 6), true},
    {World.new(10, 10), Vector2D.new(9, 0), true},
    {World.new(10, 10), Vector2D.new(0, 9), true},
    {World.new(10, 10), Vector2D.new(9, 9), true},
    {World.new(10, 10), Vector2D.new(10, 0), true},
    {World.new(10, 10), Vector2D.new(0, 10), true},
    {World.new(10, 10), Vector2D.new(10, 10), true},
    {World.new(10, 10), Vector2D.new(11, 0), false},
    {World.new(10, 10), Vector2D.new(0, 11), false},
    {World.new(10, 10), Vector2D.new(11, 11), false},
    {World.new(10, 10), Vector2D.new(11, 2), false},
    {World.new(10, 10), Vector2D.new(2, 11), false},
    {World.new(10, 10), Vector2D.new(-1, 0), false},
    {World.new(10, 10), Vector2D.new(0, -1), false},
    {World.new(10, 10), Vector2D.new(-1, -1), false},
    {World.new(10, 10), Vector2D.new(-1, 7), false},
    {World.new(10, 10), Vector2D.new(7, -1), false},
    {World.new(10, 10), Vector2D.new(-3, 0), false},
    {World.new(10, 10), Vector2D.new(0, -3), false},
    {World.new(10, 10), Vector2D.new(-3, 2), false},
    {World.new(10, 10), Vector2D.new(2, -3), false},
    {World.new(10, 10), Vector2D.new(-3, 12), false},
    {World.new(10, 10), Vector2D.new(12, -3), false}
  ]
  |> Enum.each(fn {world, vector, within} ->
    @tag world: world
    @tag vector: vector
    @tag within: within
    test "#{inspect(vector)} is#{if within, do: "", else: " not"} within #{inspect(world)}",
         ctx do
      assert World.contains?(ctx.world, ctx.vector) == ctx.within
    end
  end)
end
