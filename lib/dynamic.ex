defmodule DKP.Dynamic do
  def get_knapsack(items, capacity) do
    zeros_row = for _ <- 0..capacity, do: {0, false}
    solution = make_matrix(items, capacity, zeros_row)
    get_knapsack_items(Enum.reverse(items), capacity, Enum.reverse(solution))
  end

  defp make_matrix([], _size, _previous_row), do: []

  defp make_matrix([current_item | tail], capacity, previous_row) do
    new_row = create_row(current_item, capacity, previous_row)
    [new_row | make_matrix(tail, capacity, new_row)]
  end

  defp create_row(item, capacity, previous_row, j \\ 0)
  defp create_row(_item, capacity, _previous_row, j) when j == capacity + 1, do: []

  defp create_row({size, _} = item, capacity, previous_row, j) when size > j do
    {previous_value, _} = Enum.at(previous_row, j)
    added_value = {previous_value, false}
    [added_value | create_row(item, capacity, previous_row, j + 1)]
  end

  defp create_row({size, value} = item, capacity, previous_row, j) do
    {previous_value, _} = Enum.at(previous_row, j)
    {back_value, _} = Enum.at(previous_row, j - size)
    caculated_value = {back_value + value, true}
    added_value = Enum.max_by([caculated_value, {previous_value, false}], &elem(&1, 0))
    [added_value | create_row(item, capacity, previous_row, j + 1)]
  end

  defp get_knapsack_items(items, _capacity, _solution) when items == [], do: []

  defp get_knapsack_items([item | items_tail], capacity, [row | rows_tail]) do
    {_, added_to_knapsack} = Enum.at(row, capacity)

    if added_to_knapsack do
      [item | get_knapsack_items(items_tail, capacity - elem(item, 0), rows_tail)]
    else
      get_knapsack_items(items_tail, capacity, rows_tail)
    end
  end
end
