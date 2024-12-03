# My Advent Of Code 2024

This is the code I wrote to solve the coding challenges for the Advent of Code 2024. I'm *still* trying to learn Elixir.
Probably not going to be "idiomatic" elixir, but anything is better than nothing.

## Running elixir from docker
Installing and updating elixir natively can sometimes be a pain, so i'd like to avoid that for now.
Using the official elixir docker image I can run either the REPL or a .exs script, and I made scripts that just wrap the proper invocations.
`elixir-run` is `docker run -it --rm --name elixir-inst1 -v "$PWD":/usr/src/myapp -w /usr/src/myapp elixir elixir $@`
and `iex` is `docker run -it --rm elixir`

### Day 1
#### Part 1
<details>
	Fairly simple process: read the lists, sort them, subtract corresponding elements, sum the results.
	<summary>Spoiler</summary>
	Subtraction could result in negative distance, remember use to absolute value.
</details>

#### Part 2
<details>
	<summary>Spoiler</summary>
	The `Enum.frequencies` function makes a super-handy map of how many times a value appears in the right-hand list. Then for each element in the left-hand list
	just look it up in the map, treating nil as 0.
</details>


### Day 2
All the processing is line-oriented on this one, so that's nice. For each line, iterate through the elements and see if it matches the "safe" criteria.
#### Part 1
<details>
	<summary>Spoiler</summary>
	The trickiest bit here was checking the first two elements to find what direction the levels were headed, then passing that direction along to all the subsequent checks for that row.
	I'm actually surprised it worked because if they're equal I assumed the direction was ascending. Seems my particular input data didn't have any lines with equal first 2 elements, descending levels, AND was still safe.
</details>

#### Part 2
<details>
	I tried something that I thought would be much more elegant, involving counting the differences between elements (remembering how useful `Enum.frequencies` was last time).
	Then I had a count of how many "ups", "downs", and "bads" (difference not between 1..3) and could pattern match against those to rule things out.
	<summary>Spoiler</summary>
	But the problem I hadn't accounted for is that dropping an element from a list would change the differences, changing the frequencies of up/down/bad.
	So I wound up throwing that out. Made a function that takes a list and generates the set of all versions of it that have one element removed. Then just passed them all to `Enum.any?` to see if it could still be considered safe.
</details>


### Day 3
#### Part 1
<details>
	<summary>Spoiler</summary>
	Yay! Just a simple regex with capture groups. Go through the matches and multiply.
</details>

#### Part 2
<details>
	<summary>Spoiler</summary>
	Trickier. Converted to a list of tuples and disable/enable tokens, like `[{2, 4}, :disable, {5, 5}, {11, 8}, :enable, {8, 5}]`.
	Then after some false starts with `Enum.reduce` I settled on `Enum.chunk_while`. It lets you pass in an accumulator (used to track current enable/disable state)
	and your function can decide whether to emit a chunk of output or not, which was the key to ignoring operations while disabled.
</details>
