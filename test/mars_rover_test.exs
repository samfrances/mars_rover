defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  test "example 1" do
    input = "4 8\n(2, 3, E) LFRFF\n(0, 2, N) FFLFRFF"
    expected_output = "(4, 4, E)\n(0, 4, W) LOST"
    assert MarsRover.run(input) == expected_output
  end

  test "example 2" do
    input = "4 8\n(2, 3, N) FLLFR\n(1, 0, S) FFRLF"
    expected_output = "(2, 3, W)\n(1, 0, S) LOST"
    assert MarsRover.run(input) == expected_output
  end
end
