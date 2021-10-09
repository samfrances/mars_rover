defmodule MarsRover.World do

  @opaque t :: {pos_integer(), pos_integer()}

  @spec new(pos_integer(), pos_integer()) :: t()
  def new(width, height) when width > 0 and height > 0 do
    {width, height}
  end
  def new(_width, _height) do
    {:error, "World must have a positive width and height"}
  end

end
