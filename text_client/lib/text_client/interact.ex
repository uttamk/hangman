defmodule TextClient.Interact do
  alias TextClient.State
  alias TextClient.Player

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> Player.continue()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end
end
