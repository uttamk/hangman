defmodule Dictionary.WordList do
  def start() do
    path = Path.join(Path.dirname(__DIR__), "../../assets/words.txt")

    File.read!(path)
    |> String.split("\n")
  end


  def random_word(word_list) do
    Enum.random(word_list)
  end
end
