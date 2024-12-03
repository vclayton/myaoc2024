defmodule Aoc do
	def run(inputFile) do
		IO.puts(["Reading ", inputFile])
		{:ok, input} = File.read(inputFile)
		# IO.inspect ["Part 1:", part1(parse(input))]
		IO.inspect ["Part 2:", part2(parse(input))]
	end

	def parse(input) do
		Regex.scan(~r/(mul[(]([0-9]{1,3}),([0-9]{1,3})[)])|(do[(][)])|(don't[(][)])/, String.trim(input))
	end

	def part1(input) do
		input
		|> IO.inspect
		|> Enum.map(fn [_op, a, b] -> {String.to_integer(a), String.to_integer(b)} end)
		|> IO.inspect
		|> Enum.map(fn {a, b} -> a*b end)
		|> Enum.sum
	end

	def convert(["don't()", _, _, _, _, _]), do: :disable
	def convert(["do()", _, _, _, _]), do: :enable
	def convert([_, _, a, b]), do: {String.to_integer(a), String.to_integer(b)}

	def upchunk(:enable, {_, acc}), do: {:cont, {:enable, acc}}
	def upchunk(:disable, {_, acc}), do: {:cont, {:disable, acc}}
	def upchunk(chunk, {:enable, acc}), do: {:cont, chunk, {:enable, acc}}
	def upchunk(chunk, {:disable, acc}), do: {:cont, {:disable, acc}}
	def endchunk(a), do: {:cont, a}

	def part2(input) do
		input
		|> IO.inspect
		|> Enum.map(&convert/1)
		|> IO.inspect
		|> Enum.chunk_while({:enable, []}, &upchunk/2, &endchunk/1)
		|> IO.inspect
		|> Enum.map(fn {a, b} -> a*b end)
		|> Enum.sum
	end
end

# Aoc.run("data/sample.3.2")
Aoc.run("data/input.3")

