defmodule Vector2DTests do
  use ExUnit.Case

  import MarsRover.Vector2D

  describe "addition" do

    [
      {new(0, 0), new(1, 1), new(1, 1)},
      {new(0, 0), new(1, 0), new(1, 0)},
      {new(0, 0), new(0, 1), new(0, 1)},
      {new(0, 0), new(0, 0), new(0, 0)},
      {new(0, 0), new(-1, -1), new(-1, -1)},
      {new(0, 0), new(-1, 0), new(-1, 0)},
      {new(0, 0), new(0, -1), new(0, -1)},
      {new(5, 7), new(2, -3), new(7, 4)},
    ]
    |> Enum.each(fn {vector1, vector2, sum} ->
      @tag vector1: vector1
      @tag vector2: vector2
      @tag sum: sum
      test "#{inspect(vector1)} + #{inspect(vector2)} = #{inspect(sum)}", ctx do
        assert add(ctx.vector1, ctx.vector2) == ctx.sum
      end
    end)

  end

  @north new(0, 1)
  @east new(1, 0)
  @south new(0, -1)
  @west new(-1, 0)

  describe "rotation by +- 90 degrees" do

    [
      {@north, 90, @east},
      {@north, -90, @west},
      {@east, 90, @south},
      {@east, -90, @north},
      {@south, 90, @west},
      {@south, -90, @east},
      {@west, 90, @north},
      {@west, -90, @south},
    ]
    |> Enum.each(fn {vector, rotation, result} ->
      @tag vector: vector
      @tag rotation: rotation
      @tag result: result
      test "#{inspect(vector)} rotated #{rotation} degrees = #{inspect(result)}", ctx do
        assert rotate(ctx.vector, ctx.rotation) == ctx.result
      end
    end)

  end

end
