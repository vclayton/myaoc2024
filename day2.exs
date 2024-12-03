defmodule Aoc do
	def run(inputFile) do
		IO.puts(["Reading ", inputFile])
		{:ok, input} = File.read(inputFile)
		# IO.inspect ["Part 1:", part1(parse(input))]
		IO.inspect ["Part 2:", part2(parse(input))]
	end

	def parse(input) do
		input
		|> String.trim
		|> String.split("\n")
		|> Enum.map(fn l ->
			l
			|> String.split(" ")
			|> Enum.map(&String.to_integer(&1))
		end)
	end

	def part1(input) do
		input
		|> IO.inspect
		|> Enum.map(fn r ->
			IO.inspect({r, safe(r)})
		end)
		|> Enum.filter(fn {_, safe} -> safe end)
		|> Enum.count
	end

	def safe([h1,h2|row]) do
		dir = h1 < h2
		h1 != h2 && is_safe(h1, [h2|row], dir)
	end
	def is_safe(_current, [], _less) do
		:true
	end
	def is_safe(current, [next|tail], less) do
		diff = current - next
		ok = case less do
			:true -> diff <= -1 and diff >= -3
			:false -> diff >= 1 and diff <= 3
		end
		ok && is_safe(next, tail, less)
	end

	def drop_safe(r) do
		options = Enum.map(1..Enum.count(r), fn i -> List.delete_at(r, i-1) end)
		|> IO.inspect
		|> Enum.any?(fn combo -> safe(combo) end)
	end

	def part2(input) do
		input
		|> IO.inspect
		|> Enum.map(fn r ->
			IO.inspect({r, safe(r)})
		end)
		|> Enum.filter(fn {r, safe} ->
			safe || drop_safe(r)
		end)
		|> Enum.count
	end

	@docp """
	def diff([]) do
		0
	end
	def diff([a,b|tail]) do
		[a-b, diff([b|tail])]
	end
	def row_diffs(row) do
		row
		|> Enum.chunk_every(2, 1, :discard)
		# |> IO.inspect
		|> Enum.map(fn [a, b] -> a - b end)
	end


	def is_safe2(%{down: _d}), do: :true
	def is_safe2(%{up: _u}), do: :true
	def is_safe2(%{up: u, down: d}) when u==1 or d==1, do: :true
	def is_safe2(%{up: u, bad: b}) when b>0, do: :false
	def is_safe2(%{down: _d, bad: b}) when b>0, do: :false
	def is_safe2(_), do: :false

	def safe2(row) do
		levels = row_diffs(row)
		|> IO.inspect
		|> Enum.frequencies_by(fn diff ->
			cond do
				diff <= -1 and diff >= -3 -> :up
				diff >= 1 and diff <= 3 -> :down
				true -> :bad
			end
		end)
		|> IO.inspect
		|> is_safe2
	end
	"""

end

# Aoc.run("data/sample.2")
Aoc.run("data/input.2")

