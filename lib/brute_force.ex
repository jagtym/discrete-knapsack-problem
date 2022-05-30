defmodule DKP.BruteForce do
  def get_knapsack(items, size) do
    len = length items
    Enum.flat_map(1..len, fn x -> combination(x, items) end)
    |> Enum.filter(fn list -> total_size(list) <= size end)
    |> Enum.max_by(fn list -> total_price(list) end)
  end

  defp total_size(items) do
    items
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.sum
  end

  defp total_price(items) do
    items
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.sum
  end

  defp combination(0, _), do: [[]]
  defp combination(_, []), do: []
  defp combination(n, [x|xs]) do
    (for y <- combination(n - 1, xs), do: [x|y]) ++ combination(n, xs)
  end
end
