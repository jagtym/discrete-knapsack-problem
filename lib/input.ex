defmodule DKP.Input do
  def load_from_cli() do
    try do
      [quantity, capacity] = load_parameters()

      items_list =
        List.duplicate({}, quantity)
        |> Enum.map(fn _ -> load_item() end)

      {items_list, capacity}
    rescue
      MatchError -> "Invalid argument count when providing an item!"
      ArgumentError -> "Invalid argument passed when providing the data!"
    end
  end

  def load_from_file(file_name) do
    loaded = File.read(file_name)
    {:ok, content} = loaded
    data = content
    |> String.split("\n")
    [parameters | items] = data
    [quantity, capacity] = convert_input_to_int(parameters)
    items_list = Enum.map(items, fn x -> convert_to_item_tuple(x) end)
    if length(items_list) != quantity do
      raise ArgumentError
    end
    {items_list, capacity}
  end

  defp convert_to_item_tuple(input) do
    [weight, price] = convert_input_to_int(input)
    if weight < 0 || price < 0 do
      raise ArgumentError
    end

    {weight, price}
  end

  defp convert_input_to_int(input) do
    input
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(fn x -> String.to_integer(x) end)
  end

  defp load_parameters do
    input = IO.gets("usage: <item_quantity> <knapsack_capacity>\n")
    convert_input_to_int(input)
  end

  defp load_item do
    input = IO.gets("")
    convert_to_item_tuple(input)
  end
end
