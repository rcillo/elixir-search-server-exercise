defmodule SearchEngine do
  def server(state) do
    receive do
      {:add_document, document} ->
        index(document, state) |> server
      {:search, query, caller} ->
        msg = {:result, search(state, query)}
        send(caller, msg)
        server(state)
    end
  end

  def tokenize(document) do
    document
      |> String.downcase
      |> String.split(~r{[^a-zA-Z]}, trim: true)
  end

  def index(document, dict) do
    tokenize(document)
      |> uniq
      |> Enum.reduce(HashDict.new, add_to_dict(document))
  end

  def search(dict, token) do
    Dict.get(dict, token, [])
  end

  def uniq(tokens) do
    tokens
      |> Enum.sort
      |> do_uniq([])
  end

  defp do_uniq([], acc), do: acc

  defp do_uniq([t1, t1 | list], acc) do
    do_uniq([t1 | list], acc)
  end

  defp do_uniq([t | list], acc) do
    do_uniq(list, [t | acc])
  end

  defp add_to_dict(document) do
    fn (token, dict) ->
      if Dict.has_key?(dict, token) do
        value = Dict.get(dict, token)
        Dict.put(dict, token, [document | value])
      else
        Dict.put(dict, token, [document])
      end
    end
  end
end
