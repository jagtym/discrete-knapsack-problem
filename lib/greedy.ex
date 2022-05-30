defmodule DKP.Greedy do
  def get_knapsack(items, _size) when items == [], do: []
  def get_knapsack(items, size) do
    sorted_items = sort_items(items)
    last_fitting = get_last_fitting_index(sorted_items, size)
    Enum.slice(sorted_items, 0..last_fitting)
  end

  defp sort_items(items) do
    items
    |> Enum.sort(&(elem(&1, 1) / elem(&1, 0) > elem(&2, 1) / elem(&2, 0)))
  end

  defp get_last_fitting_index(items, size) do
    items
    |> Enum.map(&elem(&1, 0))
    |> Enum.scan(&(&1 + &2))
    |> Enum.find_index(&(&1 > size))
    |> Kernel.-(1)
  end
end
