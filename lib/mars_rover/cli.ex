defmodule MarsRover.CLI do
  def main(_args \\ []) do
    data = IO.read(:all)
    with {:ok, output} <- MarsRover.run(data) do
      IO.puts(output)
    else
      e ->
        IO.inspect(e)
        exit({:shutdown, 1})
    end
  end
end
