defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "start should return the list of words from the file system" do
    expected_word_list = File.read!("../assets/words.txt") |> String.split("\n")

    word_list = Dictionary.word_list()

    assert word_list == expected_word_list
  end
end
