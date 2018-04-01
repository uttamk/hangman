defmodule Dictionary do

  def word_list do
      File.read!("assets/words.txt")
      |> String.split("\n")
  end
end
