defmodule TextClient.Summary do
  def display(state = %{tally: tally}) do
    IO.puts [
        "\n",
        "Word so far: #{Enum.join(tally.letters, " ")}",
        "\n",
        "Turns left: #{tally.turns_left}",
        "\n",
        "Letters used: #{Enum.join(tally.letters_used, " ")}"
    ]
    state
  end
end
