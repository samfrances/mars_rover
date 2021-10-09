defmodule MarsRover.Vector2D do

  defstruct [x: 0, y: 0]

  @type t :: %__MODULE__{
    x: integer(),
    y: integer()
  }

  @spec new(x :: integer(), y :: integer()) :: t()
  def new(x, y) do
    %__MODULE__{x: x, y: y}
  end

  @spec add(t(), t()) :: t()
  def add(%__MODULE__{x: x1, y: y1}, %__MODULE__{x: x2, y: y2}) do
    new(x1 + x2, y1 + y2)
  end

end
