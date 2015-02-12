defmodule SearchEngineTest do
  use ExUnit.Case

  import SearchEngine, only: [index: 1, search: 2]

  test "index the given document" do
    assert index(document) == dict
  end

  test "search for a given token in a dictionary" do
    assert search(dict, "wow") == [document]
  end

  defp document do
    "bla bla wow"
  end

  defp dict do
    HashDict.new
      |> HashDict.put("bla", [document])
      |> HashDict.put("wow", [document])
  end
end
