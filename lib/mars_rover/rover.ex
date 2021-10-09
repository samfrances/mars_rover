defmodule MarsRover.Rover do
  alias MarsRover.Vector2D
  alias MarsRover.World
  require MarsRover.World

  defstruct world: World.new(10, 10),
            position: Vector2D.new(),
            vector: Vector2D.new(0, 1)

  @type t :: %__MODULE__{
          world: World.t(),
          position: Vector2D.t(),
          vector: Vector2D.t()
        }

  @right 90
  @left -90

  defguard is_lost(rover) when not World.contains?(rover.world, rover.position)

  @spec new(World.t(), Vector2D.t(), :east | :north | :south | :west) :: t()
  def new(world, position, orientation) do
    %__MODULE__{
      world: world,
      position: position,
      vector: Vector2D.from_compass_heading(orientation)
    }
  end

  @spec run_command(t(), :F | :R | :L) :: t()
  def run_command(rover, _command) when is_lost(rover), do: rover

  def run_command(rover = %__MODULE__{vector: vector, position: position}, :F) do
    %{rover | position: Vector2D.add(position, vector)}
  end

  def run_command(rover = %__MODULE__{vector: vector}, :R) do
    %{rover | vector: Vector2D.rotate(vector, @right)}
  end

  def run_command(rover = %__MODULE__{vector: vector}, :L) do
    %{rover | vector: Vector2D.rotate(vector, @left)}
  end

  def last_known_location(rover) do
    back_one_step = reverse(rover)

    if not is_lost(back_one_step) do
      back_one_step.position
    else
      :unknown
    end
  end

  defp reverse(rover = %__MODULE__{position: position, vector: vector}) do
    reverse_vector = Vector2D.new(-vector.x, -vector.y)
    %{rover | position: Vector2D.add(position, reverse_vector)}
  end

  defmodule Format do
    def vector(%Vector2D{x: 0, y: 1}), do: "N"
    def vector(%Vector2D{x: 1, y: 0}), do: "E"
    def vector(%Vector2D{x: 0, y: -1}), do: "S"
    def vector(%Vector2D{x: -1, y: 0}), do: "W"
  end
end

defimpl String.Chars, for: MarsRover.Rover do
  alias MarsRover.Rover.Format
  alias MarsRover.Rover
  require MarsRover.Rover

  def to_string(rover = %MarsRover.Rover{world: _world, vector: vector}) do
    is_lost? = Rover.is_lost(rover)
    lost_string = if is_lost?, do: " LOST", else: ""

    position =
      if is_lost? do
        Rover.last_known_location(rover)
      else
        rover.position
      end

    "(#{position.x}, #{position.y}, #{Format.vector(vector)})#{lost_string}"
  end
end
