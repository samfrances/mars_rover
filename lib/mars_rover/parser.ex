defmodule MarsRover.Parser do
  alias MarsRover.World
  alias MarsRover.Rover
  alias MarsRover.Vector2D

  @positive_int "[1-9]\\d*"
  @non_neg_int "\\d+"
  @heading "(N|E|S|W)"
  @commands "(F|R|L)"

  def parse_world_line(line) do
    pattern = ~r/^(?<width>#{@positive_int}) (?<height>#{@positive_int})$/

    captures =
      line
      |> String.trim()
      |> then(&Regex.named_captures(pattern, &1))

    with %{"height" => height, "width" => width} <- captures do
      {parsed_width, ""} = Integer.parse(width)
      {parsed_height, ""} = Integer.parse(height)
      World.new(parsed_width, parsed_height)
    else
      _e -> {:error, "failed to parse world line"}
    end
  end

  def parse_instruction_line(line) do
    pattern =
      ~r/^\((?<x>#{@non_neg_int}), (?<y>#{@non_neg_int}), (?<heading>#{@heading})\) (?<commands>#{@commands}+)$/

    captures =
      line
      |> String.trim()
      |> then(&Regex.named_captures(pattern, &1))

    with %{"x" => x, "y" => y, "heading" => heading, "commands" => commands} <- captures do
      {parsed_x, ""} = Integer.parse(x)
      {parsed_y, ""} = Integer.parse(y)
      parsed_heading = heading_from_string(heading)

      parsed_commands =
        commands
        |> String.split("", trim: true)
        |> Enum.map(&command_from_string/1)

      %{x: parsed_x, y: parsed_y, heading: parsed_heading, commands: parsed_commands}
    else
      _e -> {:error, "failed to parse instruction line"}
    end
  end

  defp heading_from_string("N"), do: :north
  defp heading_from_string("E"), do: :east
  defp heading_from_string("S"), do: :south
  defp heading_from_string("W"), do: :west

  defp command_from_string("F"), do: :F
  defp command_from_string("L"), do: :L
  defp command_from_string("R"), do: :R

  def parse_file(text) do
    lines = text |> String.split("\n", trim: true)

    if length(lines) < 2 do
      {:error, "invalid data"}
    else
      parse_lines(lines)
    end
  end

  defp parse_lines(lines = [world_line | robot_lines]) when length(lines) > 1 do
    with world <- parse_world_line(world_line) do
      parse_robot_lines(world, robot_lines)
    end
  end

  defp parse_robot_lines(world, robot_lines) do
    parsed =
      robot_lines
      |> Enum.map(&parse_instruction_line/1)

    if Enum.any?(parsed, fn parsed -> match?({:error, _msg}, parsed) end) do
      {:error, "error parsing instructions"}
    else
      programs =
        parsed
        |> Enum.map(fn %{x: x, y: y, heading: heading, commands: commands} ->
          {
            Rover.new(world, Vector2D.new(x, y), heading),
            commands
          }
        end)

      {:ok, programs}
    end
  end
end
