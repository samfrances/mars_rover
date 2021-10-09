# Mars Rover kata

Write a program that takes in commands and moves one or more robots around
Mars.

- The world should be modelled as a grid with size m x n
- Your program should read the input, update the robots, and print out the final states of the robots
- Each robot has a position (x, y), and an orientation (N, E, S, W)
- Each robot can move forward one space (F), rotate left by 90 degrees (L), or rotate right by 90 degrees (R)
- If a robot moves off the grid, it is marked as ‘lost’ and its last valid grid position and orientation is recorded
- Going from x -> x + 1 is in the easterly direction, and y -> y + 1 is in the northerly direction. i.e. (0, 0) represents the south-west corner of the grid

The input takes the form:

```
4 8
(2, 3, E) LFRFF
(0, 2, N) FFLFRFF
```

The first line of the input ‘4 8’ specifies the size of the grid. The subsequent lines each
represent the initial state and commands for a single robot. (0, 2, N) specifies the initial state
of the form (x, y, orientation). FFLFRFF represents the sequence of movement commands
for the robot.

The output should take the form:

```
(4, 4, E)
(0, 4, W) LOST
```

Each line represents the final position and orientation of the robots of the form (x, y,
orientation) and optionally whether the robot was lost.

Another example for the input:

```
4 8
(2, 3, N) FLLFR
(1, 0, S) FFRLF
```

The output would be:

```
(2, 3, W)
(1, 0, S) LOST
```

## Usage

### Run the tests

Run `mix test` or `mix test --trace`.

### Run "type checks"

Run `mix dialyzer`.

### Build the CLI

Run `mix escript.build`

### Example CLI usage

```
$ ./mars_rover <<EOF
4 8
(2, 3, N) FLLFR
(1, 0, S) FFRLF
EOF
```
Output:
```
(2, 3, W)
(1, 0, S) LOST
```

## Scope for further development

- [ ] Better CLI interface
- [ ] Process each robot concurrently?
- [ ] Collision detection?
- [ ] Property-based testing?
- [ ] More granular directions, rather than just compass headings
- [ ] Some sort of graphical interface?

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mars_rover` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mars_rover, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mars_rover](https://hexdocs.pm/mars_rover).

