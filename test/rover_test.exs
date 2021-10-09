defmodule RoverTest do
  use ExUnit.Case

  alias MarsRover.World
  alias MarsRover.Rover
  alias MarsRover.Vector2D

  @world World.new(10, 10)

  test "forward north" do
    result =
      Rover.new(@world, Vector2D.new(0, 0), :north)
      |> Rover.run_command(:F)

    assert result == Rover.new(@world, Vector2D.new(0, 1), :north)
  end

  test "forward east" do
    result =
      Rover.new(@world, Vector2D.new(0, 0), :east)
      |> Rover.run_command(:F)

    assert result == Rover.new(@world, Vector2D.new(1, 0), :east)
  end

  test "forward south" do
    result =
      Rover.new(@world, Vector2D.new(0, 10), :south)
      |> Rover.run_command(:F)

    assert result == Rover.new(@world, Vector2D.new(0, 9), :south)
  end

  test "forward west" do
    result =
      Rover.new(@world, Vector2D.new(10, 0), :west)
      |> Rover.run_command(:F)

    assert result == Rover.new(@world, Vector2D.new(9, 0), :west)
  end

  test "right rotate" do
    north = Rover.new(@world, Vector2D.new(1, 1), :north)
    east = Rover.new(@world, Vector2D.new(1, 1), :east)
    south = Rover.new(@world, Vector2D.new(1, 1), :south)
    west = Rover.new(@world, Vector2D.new(1, 1), :west)

    assert north |> Rover.run_command(:R) == east
    assert north |> Rover.run_command(:R) |> Rover.run_command(:R) == south

    assert north
           |> Rover.run_command(:R)
           |> Rover.run_command(:R)
           |> Rover.run_command(:R) == west

    assert north
           |> Rover.run_command(:R)
           |> Rover.run_command(:R)
           |> Rover.run_command(:R)
           |> Rover.run_command(:R) == north
  end

  test "left rotate" do
    north = Rover.new(@world, Vector2D.new(1, 1), :north)
    east = Rover.new(@world, Vector2D.new(1, 1), :east)
    south = Rover.new(@world, Vector2D.new(1, 1), :south)
    west = Rover.new(@world, Vector2D.new(1, 1), :west)

    assert north |> Rover.run_command(:L) == west
    assert north |> Rover.run_command(:L) |> Rover.run_command(:L) == south

    assert north
           |> Rover.run_command(:L)
           |> Rover.run_command(:L)
           |> Rover.run_command(:L) == east

    assert north
           |> Rover.run_command(:L)
           |> Rover.run_command(:L)
           |> Rover.run_command(:L)
           |> Rover.run_command(:L) == north
  end

  describe "lost rovers don't move:" do
    [
      {"lost north", Rover.new(@world, Vector2D.new(1, 11), :north)},
      {"lost east", Rover.new(@world, Vector2D.new(11, 1), :north)},
      {"lost south", Rover.new(@world, Vector2D.new(1, -1), :north)},
      {"lost west", Rover.new(@world, Vector2D.new(-1, 1), :north)},
      {"lost northeast", Rover.new(@world, Vector2D.new(11, 11), :north)},
      {"lost northwest", Rover.new(@world, Vector2D.new(-1, 11), :north)},
      {"lost southeast", Rover.new(@world, Vector2D.new(11, -1), :north)},
      {"lost southwest", Rover.new(@world, Vector2D.new(-1, -1), :north)}
    ]
    |> Enum.each(fn {description, rover} ->
      @tag description: description
      @tag rover: rover
      test description, ctx do
        assert ctx.rover |> Rover.run_command(:F) == ctx.rover
        assert ctx.rover |> Rover.run_command(:R) == ctx.rover
        assert ctx.rover |> Rover.run_command(:L) == ctx.rover
      end
    end)
  end

  describe "last known location:" do
    [
      {"long out of bounds", Vector2D.new(100, 100), :north, :unknown},
      {"just north", Vector2D.new(0, 11), :north, Vector2D.new(0, 10)},
      {"just south", Vector2D.new(0, -1), :south, Vector2D.new(0, 0)},
      {"just east", Vector2D.new(11, 5), :east, Vector2D.new(10, 5)},
      {"just west", Vector2D.new(-1, 5), :west, Vector2D.new(0, 5)}
    ]
    |> Enum.each(fn {description, position, heading, last_known_location} ->
      @tag description: description
      @tag position: position
      @tag heading: heading
      @tag last_known_location: last_known_location
      test description, ctx do
        assert Rover.new(@world, ctx.position, ctx.heading)
               |> Rover.last_known_location() == ctx.last_known_location
      end
    end)
  end
end
