defmodule Dictionary.WordList do
  @me __MODULE__
  def start_link() do
    Agent.start(&read_list/0, name: @me)
  end

  def random_word do
    word_list() |> Enum.random()
  end

  def word_list do
    Agent.get(@me, fn list -> list end)
  end

  defp read_list do
    Path.join(Path.dirname(__DIR__), "../../assets/words.txt")
    |> File.read!()
    |> String.split("\n")
  end
end
