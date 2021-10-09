defmodule MarsRover do
  alias MarsRover.Parser
  alias MarsRover.Rover

  def run(file_text) do
    with {:ok, programs} <- Parser.parse_file(file_text) do
      printout =
        programs
        |> Enum.map(fn {robot, commands} ->
          commands
          |> Enum.reduce(robot, &run_command/2)
        end)
        |> Enum.map(&to_string/1)
        |> Enum.join("\n")
      {:ok, printout}
    end
  end

  defp run_command(command, rover) do
    Rover.run_command(rover, command)
  end
end
