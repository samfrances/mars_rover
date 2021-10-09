defmodule MarsRover.Vector2D do
  defstruct x: 0, y: 0

  @type t :: %__MODULE__{
          x: integer(),
          y: integer()
        }

  @spec new :: t()
  def new() do
    new(0, 0)
  end

  @spec new(x :: integer(), y :: integer()) :: t()
  def new(x, y) do
    %__MODULE__{x: x, y: y}
  end

  @spec add(t(), t()) :: t()
  def add(%__MODULE__{x: x1, y: y1}, %__MODULE__{x: x2, y: y2}) do
    new(x1 + x2, y1 + y2)
  end

  @spec rotate(t(), -90 | 90) :: t()
  def rotate(%__MODULE__{x: x, y: y}, 90) do
    new(y, -x)
  end

  def rotate(%__MODULE__{x: x, y: y}, -90) do
    new(-y, x)
  end

  def rotate(_vector, degrees) do
    raise "Vector rotation currently only supports +-90 degrees. Received: #{degrees}"
  end

  @spec from_compass_heading(:east | :north | :south | :west) :: t()
  def from_compass_heading(:north) do
    new(0, 1)
  end

  def from_compass_heading(:east) do
    new(1, 0)
  end

  def from_compass_heading(:south) do
    new(0, -1)
  end

  def from_compass_heading(:west) do
    new(-1, 0)
  end
end
