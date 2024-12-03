defmodule Aoc do
	def run(inputFile) do
		IO.puts(["Reading ", inputFile])
		{:ok, input} = File.read(inputFile)
		# IO.inspect ["Part 1:", part1(parse(input))]
		IO.inspect ["Part 2:", part2(parse(input))]
	end

	# {seeds, %maps{type => ranges}}
	def parse(input) do
		input
		|> String.trim
		|> String.split("\n")
		|> Enum.map(fn l ->
			l
			|> String.split("   ")
			|> Enum.map(&String.to_integer(&1))
		end)
	end

	def part1(input) do
		input
		[ta, tb] = List.zip(input)
		a = Enum.sort(Tuple.to_list(ta))
		b = Enum.sort(Tuple.to_list(tb))
		sorted = List.zip([a, b])
		|> Enum.map(fn {l, r} ->
			abs(r - l)
		end)
		|> IO.inspect
		|> Enum.sum
	end

	def part2(input) do
		[ta, tb] = List.zip(input)
		l = Enum.sort(Tuple.to_list(ta))
		r = Enum.sort(Tuple.to_list(tb))
		freq = Enum.frequencies(r)
		|> IO.inspect
		l
		|> Enum.map(fn a ->
			mult = case freq[a] do
				nil -> 0
				f -> f
			end
			a * mult
		end)
		|> IO.inspect
		|> Enum.sum
		|> IO.inspect
	end

end

# Aoc.run("data/sample.1")
Aoc.run("data/input.1")

