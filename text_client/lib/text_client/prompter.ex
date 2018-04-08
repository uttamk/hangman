defmodule TextClient.Prompter do
  def accept_move(state) do
      IO.gets("Your guess: ")
      |> String.replace("\n", "")
      |> check_input(state)
  end

  defp check_input({:error, reason}, _) do
    IO.puts("An error occurred: #{reason}")
    exit(:normal)
  end

  defp check_input({:eof, _}, _) do
    IO.puts("Looks like you gave up ...")
    exit(:normal)
  end

  defp check_input(guess, state) do
    cond do
      guess =~ ~r/[a-z]/ ->
        %{state | guessed: guess}

      true ->
        IO.puts("Please enter a lowercase character")
        accept_move(state)
    end
  end
end
