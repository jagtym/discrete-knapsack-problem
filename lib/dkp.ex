defmodule DKP do
  def app() do
    try do
      out = DKP.Input.load_from_cli()
      run(out)
    rescue
      MatchError -> "Invalid argument count when providing an item!"
      ArgumentError -> "Invalid argument passed when providing the data!"
    end
  end
  def app(file_name) do
    # try do
      out = DKP.Input.load_from_file(file_name)
      run(out)
    # rescue
    #   MatchError -> "Invalid argument count when providing an item!"
    #   ArgumentError -> "Invalid argument passed when providing the data!"
    # end
  end

  def run(output) do
    {item_list, capacity} = output
    IO.puts "\n"
    IO.puts "Greedy: "
    output = DKP.Greedy.get_knapsack(item_list, capacity)
    IO.puts("Total value: #{total_value(output)}")
    IO.puts("Total size: #{total_size(output)}")
    IO.inspect(output)

    IO.puts "\n"
    IO.puts "BruteForce: "
    output = DKP.BruteForce.get_knapsack(item_list, capacity)
    IO.puts("Total value: #{total_value(output)}")
    IO.puts("Total size: #{total_size(output)}")
    IO.inspect(output)

    IO.puts "\n"
    IO.puts "Dynamic Programming: "
    output = DKP.Dynamic.get_knapsack(item_list, capacity)
    IO.puts("Total value: #{total_value(output)}")
    IO.puts("Total size: #{total_size(output)}")
    IO.inspect(output)
    :ok
  end

  defp total_value(output) do
    output
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.sum
  end

  defp total_size(output) do
    output
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.sum
  end
end
