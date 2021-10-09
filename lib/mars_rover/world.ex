defmodule MarsRover.World do
  defstruct width: 1,
            height: 1

  defguard contains?(world, vector)
           when vector.x >= 0 and vector.y >= 0 and vector.x <= world.width and
                  vector.y <= world.height

  @opaque t :: %__MODULE__{
            width: pos_integer(),
            height: pos_integer()
          }

  @spec new(pos_integer(), pos_integer()) :: t()
  def new(width, height) when width > 0 and height > 0 do
    %__MODULE__{width: width, height: height}
  end

  def new(_width, _height) do
    {:error, "World must have a positive width and height"}
  end
end
