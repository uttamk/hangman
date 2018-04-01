defmodule Dictionary do

  def word_list do
      path = Path.join(Path.dirname(__DIR__), "../assets/words.txt")
      File.read!(path)
      |> String.split("\n")
  end
end
