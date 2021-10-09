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
end
